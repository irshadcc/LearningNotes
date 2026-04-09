
1. DispatchKey is made of two components
    -------------- --------------------
   |Functionality (48) |  Backend (16) |
    ------------------------------------
   Example of functionality : PythonDispatch, Autograd, Dense, Sparse, Quantised etc...
   Example of Backend : CPU, CUDA, PrivateUse 


## OperatorEntry table initialisation 

1. For some functionality, it can have multiple backends
   Example : (Sparse) x (CPU, CUDA, PrivateUse,....)

   ```c++
   constexpr bool isPerBackendFunctionalityKey(DispatchKey k) {
        if (k == DispatchKey::Dense || k == DispatchKey::Quantized ||
            k == DispatchKey::Sparse || k == DispatchKey::SparseCsr ||
            k == DispatchKey::AutogradFunctionality ||
            k == DispatchKey::NestedTensor) {
            return true;
        } else {
            return false;
        }
    }
    ```
2. Computing offset and masks 

    ```c++
    std::array<FunctionalityOffsetAndMask, num_functionality_keys>
        initializeFunctionalityOffsetsAndMasks() {
        std::array<FunctionalityOffsetAndMask, num_functionality_keys>
            offsets_and_masks;
        // manually set the first entry, which corresponds to Undefined.
        offsets_and_masks[0] = FunctionalityOffsetAndMask(0, 0);
        // loop through every functionality key (aside from Undefined).
        for (const auto functionality_idx : c10::irange(1, num_functionality_keys)) {
            // functionality_idx should be Dense -> 1, ...
            auto prev_offset_and_mask = offsets_and_masks[functionality_idx - 1];
            auto k = static_cast<DispatchKey>(functionality_idx);

            // If the previous functionality was not per-backend, then we can just
            // increment the previous offset. Otherwise, the next offset =
            // previous_offset + num_backends.
            auto next_offset = prev_offset_and_mask.offset +
                (prev_offset_and_mask.mask == 0 ? 1 : num_backends);
            // the mask is used in the runtime index calculation to find the offset of
            // the backend. For non-per-backend functionalities, this offset should
            // always be 0. Otherwise, we need to get the index of the backend (which we
            // can do using a backend mask).
            auto next_mask = isPerBackendFunctionalityKey(k) ? full_backend_mask : 0;
            offsets_and_masks[functionality_idx] =
                FunctionalityOffsetAndMask(next_offset, next_mask);
        }
        /**
                Output : 
            __________________
        0  |   0   |    0      | 
        1  |   1   |  0xffff   | (Dense)
        2  |   2   |    0      |
        3  |   3   |    0      |
        4  |   4   |    0      |
        5  |  4+16 |  0xffff   |
             (so on .......)
        **/
    ```
3. Getting Dispatch index 
    ```c++
      int getDispatchTableIndexForDispatchKeySet() const {
        auto functionality_idx =
            DispatchKeySet(repr_ >> num_backends).indexOfHighestBit();
        auto offset_and_mask = offsetsAndMasks()[functionality_idx];
        // Mask the functionality bits out first, then right-shift by 1.
        // right-shifting by 1 because everything is zero-indexed.
        // E.g. 000001 (CPU) should give us an offset of 0, 000010 (CUDA) should
        // give us an offset of 1, etc.
        auto backend_idx =
            DispatchKeySet((repr_ & offset_and_mask.mask) >> 1).indexOfHighestBit();
        return offset_and_mask.offset + backend_idx;
    }
    /**
     For example if the functionality is dense, the functionality_idx=1
     offset_and_mask = (1, 0xffff)
     At last it will return the index in the entry table
    **/
  ```
  




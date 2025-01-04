#include <cstring>
#include <string>
#include <stdexcept>

#define CHECK_STATUS(status) \
  if (status != StatusCode::OK) \
    throw std::runtime_error(status.message()) ;

enum class StatusCode {
  OK,
  INVALID_ARGUMENT,
  OOM
};

class Status {

public:
  Status(StatusCode code) : code_(code), msg_(nullptr, 0) {}

  Status(StatusCode code, const std::string& msg) : code_(code), msg_(msg) {}

  StatusCode code_;
  std::string msg_;

  inline const StatusCode& status() const { return code_; }

  inline const std::string& message() const { return msg_ ; }

  operator StatusCode() { return code_; }

};

class Buffer {
public:

  Buffer():buffer_(nullptr), size_(0) {}

  Buffer(char* buffer, size_t size): buffer_(buffer), size_(size) {}

  ~Buffer() {
    if (buffer_) {
      delete[] buffer_;
    }
  }

  [[nodiscard]]
  Status Resize(size_t new_size) {

    if (new_size < size_) {
      return {StatusCode::INVALID_ARGUMENT, "New size is less than size"};
    }

    char* new_buffer = new char[new_size]();
    if (buffer_) {
      std::memcpy(new_buffer, buffer_, size_);
    }

    delete[] buffer_;
    buffer_ = new_buffer;
    return StatusCode::OK;
  }


  char* buffer_;
  size_t size_;
};




int main() {

  Buffer buffer;
  CHECK_STATUS(buffer.Resize(100));




  return 0;
}
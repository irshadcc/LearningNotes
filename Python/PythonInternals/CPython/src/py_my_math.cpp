#include "my_math.h"
#include "pytypedefs.h"

#include <Python.h>

typedef struct {
    PyObject_HEAD
    MyMath my_math;
} DemoPy_MyMath;

PyObject *my_math_new(PyTypeObject *subtype, PyObject *args, PyObject *kwds) {
    DemoPy_MyMath* my_math = new DemoPy_MyMath();

    return reinterpret_cast<PyObject*>(my_math);
}

PyObject *my_math_dealloc(PyTypeObject *subtype, PyObject *args, PyObject *kwds) {

    return NULL;
}



PyTypeObject mymath_type {
    PyVarObject_HEAD_INIT(NULL, 0),
    .tp_name = "MyMath",
    .tp_basicsize = sizeof(DemoPy_MyMath),
    .tp_doc = PyDoc_STR("My objects"),
    .tp_new = my_math_new,
    .tp_dealloc = (destructor)my_math_dealloc,
    .tp_repr = NULL 
};




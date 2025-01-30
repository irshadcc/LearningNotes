#include <ostream>
#include <string>
#include <iostream>

#include <Python.h>
#include <modsupport.h>

#include "my_math.h"
#include "object.h"


#define UNUSED(x) (void)(x)

extern PyTypeObject mymath_type;

static PyObject* get_version(PyObject* self, PyObject* args) {
    UNUSED(args);
    UNUSED(self);
    std::string version = "1.0.0";
    PyThreadState *mainstate = PyThreadState_Get();
    PyInterpreterState* state = mainstate->interp;

    return PyUnicode_FromString(version.c_str());
}

static PyMethodDef demo_methods[]  = {
    {"get_version", get_version, METH_NOARGS, "Get Version"},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef demo_module = {
    PyModuleDef_HEAD_INIT,
    "demo",
    "A simple demo",
    -1,
    // NULL,
    demo_methods,
    NULL,
    NULL,
    NULL,
    NULL
};

PyMODINIT_FUNC PyInit_demo() {
    PyObject* module = PyModule_Create(&demo_module);
    if (module == NULL) {
        return NULL;
    }

    std::cout << "Ref count math type " << Py_REFCNT(&mymath_type) << std::flush << std::endl;
    Py_INCREF(&mymath_type);
    std::cout << "Ref count math type " << Py_REFCNT(&mymath_type) << std::flush << std::endl;
    PyModule_AddObject(module, "MyMath", (PyObject*) &mymath_type);
    return module;
}
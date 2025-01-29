#include <string>
#include <Python.h>
#include "methodobject.h"
#include "moduleobject.h"
#include "my_math.h"
#include "unicodeobject.h"

#define UNUSED(x) (void)(x)

static PyObject* get_version(PyObject* self, PyObject* closure) {
    UNUSED(closure);
    UNUSED(self);
    std::string version = "1.0.0";
    return PyUnicode_FromString(version.c_str());
}


static PyMethodDef demo_methods[]  = {
    {"get_version", get_version, METH_NOARGS, "Get Version"}
};

static struct PyModuleDef demo_module = {
    PyModuleDef_HEAD_INIT,
    "demo",
    "A simple demo",
    -1,
    demo_methods,
    NULL,
    NULL,
    NULL,
    NULL
};

PyMODINIT_FUNC PyInit_demo(void) {
    PyObject* module = PyModule_Create(&demo_module);
    if (module == NULL) {
        return NULL;
    }

    return module;
}
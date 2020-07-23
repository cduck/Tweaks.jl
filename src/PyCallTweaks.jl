module PyCallTweaks

import Base: print

using PyCall


"""
    print(io, pyobj)

Print the `str()` form of the Python object.
"""
Base.print(io::IO, obj::PyCall.PyObject) = print(io, py"str"(obj))


end

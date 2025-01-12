# VTK cell definitions

# Definitions copied from the vtkCellType.h file of the VTK source code:
# https://raw.githubusercontent.com/Kitware/VTK/master/Common/DataModel/vtkCellType.h

__precompile__()

module VTKCellTypes

export VTKCellType

struct VTKCellType
    vtk_name::String
    vtk_id::UInt8
    nodes::Int
end

const VTK_CELL_TYPES = Dict{UInt8, VTKCellType}()

# Construction of VTKCellType objects from the integer vtk id
function VTKCellType(vtkid::Integer)
    id = UInt8(vtkid)
    if !haskey(VTK_CELL_TYPES, id)
        throw(ArgumentError("unknown vtkid = $vtkid"))
    end
    VTK_CELL_TYPES[id]
end

# Define a VTK cell type
macro add(ctype, id, nodes)
    name = string(ctype)
    quote
        const $(esc(ctype)) = VTKCellType($name, $id, $nodes)
        VTK_CELL_TYPES[$id] = $(esc(ctype))
    end
end

# Linear cells
@add VTK_EMPTY_CELL 0 0
@add VTK_VERTEX 1  1
@add VTK_POLY_VERTEX 2 -1
@add VTK_LINE 3  2
@add VTK_POLY_LINE 4 -1
@add VTK_TRIANGLE 5  3
@add VTK_TRIANGLE_STRIP 6 -1
@add VTK_POLYGON 7 -1
@add VTK_PIXEL 8  4
@add VTK_QUAD 9  4
@add VTK_TETRA 10 4
@add VTK_VOXEL 11 8
@add VTK_HEXAHEDRON 12 8
@add VTK_WEDGE 13 6
@add VTK_PYRAMID 14 5
@add VTK_PENTAGONAL_PRISM 15 10
@add VTK_HEXAGONAL_PRISM 16 12

# Quadratic, isoparametric cells
@add VTK_QUADRATIC_EDGE 21 3
@add VTK_QUADRATIC_TRIANGLE 22 6
@add VTK_QUADRATIC_QUAD 23 8
@add VTK_QUADRATIC_POLYGON 36 -1
@add VTK_QUADRATIC_TETRA 24 10
@add VTK_QUADRATIC_HEXAHEDRON 25 20
@add VTK_QUADRATIC_WEDGE 26 15
@add VTK_QUADRATIC_PYRAMID 27 13
@add VTK_BIQUADRATIC_QUAD 28 9
@add VTK_TRIQUADRATIC_HEXAHEDRON 29 27
@add VTK_QUADRATIC_LINEAR_QUAD 30 6
@add VTK_QUADRATIC_LINEAR_WEDGE 31 12
@add VTK_BIQUADRATIC_QUADRATIC_WEDGE 32 18
@add VTK_BIQUADRATIC_QUADRATIC_HEXAHEDRON 33 24
@add VTK_BIQUADRATIC_TRIANGLE 34 7

# Cubic, isoparametric cell
@add VTK_CUBIC_LINE 35 4

# Special class of cells formed by convex group of points
@add VTK_CONVEX_POINT_SET 41 -1

# Polyhedron cell (consisting of polygonal faces)
@add VTK_POLYHEDRON 42 -1

# Higher order cells in parametric form
@add VTK_PARAMETRIC_CURVE 51 -1
@add VTK_PARAMETRIC_SURFACE 52 -1
@add VTK_PARAMETRIC_TRI_SURFACE 53 -1
@add VTK_PARAMETRIC_QUAD_SURFACE 54 -1
@add VTK_PARAMETRIC_TETRA_REGION 55 -1
@add VTK_PARAMETRIC_HEX_REGION 56 -1

# Higher order cells
@add VTK_HIGHER_ORDER_EDGE 60 -1
@add VTK_HIGHER_ORDER_TRIANGLE 61 -1
@add VTK_HIGHER_ORDER_QUAD 62 -1
@add VTK_HIGHER_ORDER_POLYGON 63 -1
@add VTK_HIGHER_ORDER_TETRAHEDRON 64 -1
@add VTK_HIGHER_ORDER_WEDGE 65 -1
@add VTK_HIGHER_ORDER_PYRAMID 66 -1
@add VTK_HIGHER_ORDER_HEXAHEDRON 67 -1

end # module

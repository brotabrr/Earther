# SCROLL TO VERY BOTTOM TO CONFIG THIS SCRIPT!!

def obj_to_lua(obj_path, out_path, scale=1.0):
    vertices = []
    triangles = []

    with open(obj_path, "r") as f:
        for line in f:
            line = line.strip()

            if line.startswith("v "):
                parts = line.split()
                x = float(parts[1]) * scale
                y = float(parts[2]) * scale
                z = float(parts[3]) * scale
                vertices.append((x, y, z))

            elif line.startswith("f "):
                parts = line.split()[1:]
                face = []

                for p in parts:
                    idx = int(p.split("/")[0]) - 1
                    face.append(idx)

                if len(face) == 3:
                    triangles.append((face[0], face[1], face[2]))
                elif len(face) > 3:
                    for i in range(1, len(face) - 1):
                        triangles.append((face[0], face[i], face[i + 1]))

    with open(out_path, "w") as out:
        out.write("return {\n")
        out.write("  vertices = {\n")
        for v in vertices:
            out.write(f"    {{{v[0]:.6f}, {v[1]:.6f}, {v[2]:.6f}}},\n")
        out.write("  },\n")

        out.write("  triangles = {\n")
        for t in triangles:
            out.write(f"    {{{t[0] + 1}, {t[1] + 1}, {t[2] + 1}}},\n")
        out.write("  }\n")
        out.write("}\n")

    print(f"vertices: {len(vertices)}")
    print(f"triangles: {len(triangles)}")


# CONFIG HERE!!
# EXAMPLE: obj_to_lua("yourmodelname.obj", "outputname.lua", scale=1.0)
obj_to_lua("model.obj", "mesh.lua", scale=1.0)

input("press enter to exit")

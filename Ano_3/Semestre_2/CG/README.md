<div align="center">

# 🎮 CG - Computer Graphics

![C++](https://img.shields.io/badge/C++-11-00599C?style=for-the-badge&logo=cplusplus&logoColor=white)
![OpenGL](https://img.shields.io/badge/OpenGL-3.3-5586A4?style=for-the-badge&logo=opengl&logoColor=white)
![CMake](https://img.shields.io/badge/CMake-3.10-064F8C?style=for-the-badge&logo=cmake&logoColor=white)
![Year](https://img.shields.io/badge/Year-3rd-brightgreen?style=for-the-badge)
![Semester](https://img.shields.io/badge/Semester-2nd-blue?style=for-the-badge)

*Custom 3D rendering engine with OpenGL, scene graphs, lighting, textures, and animations*

[📂 Repository](../..) • [🎓 Course Info](#-about) • [🚀 Quick Start](#-getting-started)

</div>

---

## 📖 About

**CG (Computação Gráfica)** is the Computer Graphics course in the Software Engineering degree at Universidade do Minho. The course focuses on the fundamentals of 3D computer graphics, from primitive generation to real-time rendering with OpenGL.

This repository contains:
- 🧊 A **3D Primitive Generator** for creating geometric models (planes, boxes, spheres, cones, tori, Bézier patches)
- 🎮 A **Custom 3D Engine** with scene graph architecture, VBO rendering, lighting, textures, and Catmull-Rom animations
- 🪐 A **Solar System Demo** showcasing all engine features in an interactive scene
- 🧪 **Phase-specific test suites** covering each development milestone

### 🎯 Learning Objectives

- Understand the **3D rendering pipeline** and how graphics are drawn on screen
- Implement **geometric transformations** (translation, rotation, scaling) in hierarchical scene graphs
- Work with **OpenGL shaders**, VBOs, and modern rendering techniques
- Design and implement **camera systems** (orbital and free-look)
- Apply **lighting models** (point, directional, spot) and material properties
- Perform **texture mapping** and image-based rendering with DevIL
- Create smooth **animations** using Catmull-Rom spline interpolation

---

## ✨ Key Features

<table>
<tr>
<td width="50%">

### 🧊 3D Primitive Generator
- Generates standard primitives: `plane`, `box`, `sphere`, `cone`, `torus`
- Supports complex shapes like **Bézier Patches**
- Procedural generation (e.g., custom comets with seeds and roughness)
- Outputs optimized `.3d` format files

</td>
<td width="50%">

### 🎮 Advanced 3D Engine
- **Scene Graph Architecture:** Hierarchical XML-based configuration
- **Efficient Rendering:** Uses Vertex Buffer Objects (VBOs)
- **Dynamic Lighting & Materials:** Point, directional, and spot lights; Diffuse, specular, ambient, and emissive properties
- **Texture Mapping:** Integrated with DevIL

</td>
</tr>
<tr>
<td width="50%">

### 🎥 Camera System
- **Orbital Camera:** Rotate around the scene origin (Explorer mode)
- **Free Camera:** First-person style movement (FPS mode)
- Dynamic aspect ratio adjustment

</td>
<td width="50%">

### 🏃‍♂️ Animations
- **Catmull-Rom Splines:** Smooth curve translations using control points
- **Continuous Rotations:** Time-based transformations

</td>
</tr>
</table>

---

## 🛠️ Technologies

| Technology | Purpose |
|:----------:|:--------|
| ![C++](https://img.shields.io/badge/C++-11-00599C?style=flat-square&logo=cplusplus&logoColor=white) | Core language for engine and generator |
| ![OpenGL](https://img.shields.io/badge/OpenGL-3.3-5586A4?style=flat-square&logo=opengl&logoColor=white) | 3D rendering API |
| ![GLUT](https://img.shields.io/badge/GLUT-FreeGLUT-green?style=flat-square) | Window management and input handling |
| ![GLEW](https://img.shields.io/badge/GLEW-2.0-blue?style=flat-square) | OpenGL extension loading |
| ![DevIL](https://img.shields.io/badge/DevIL-1.8-orange?style=flat-square) | Image loading for textures |
| ![CMake](https://img.shields.io/badge/CMake-3.10-064F8C?style=flat-square&logo=cmake&logoColor=white) | Cross-platform build system |
| ![TinyXML2](https://img.shields.io/badge/TinyXML2-XML-9B59B6?style=flat-square) | Scene file parsing |
| ![Doxygen](https://img.shields.io/badge/Doxygen-Docs-2C8EBB?style=flat-square) | Code documentation generation |

---

## 🚀 Getting Started

### Prerequisites

- **C++11** compatible compiler
- **CMake** (>= 3.10)
- **OpenGL**, **GLUT**, **GLEW**, and **DevIL** (Image Library)

*On Linux (Ubuntu/Debian):*
```bash
sudo apt-get install cmake libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev libglew-dev libdevil-dev
```

### Build the Project

1. **Clone the repository** and open a terminal in its root directory.

2. **Compile using CMake:**
```bash
mkdir -p build
cd build
cmake ..
make
```

This will generate two executables in the `build` directory: `generator` and `engine`.

### Build Documentation

The project uses Doxygen for code documentation. To generate the HTML documentation:

```bash
doxygen Doxyfile
```

The generated documentation will be available in the `docs` directory. Open `docs/index.html` in your browser.

---

## 🚀 Usage

### 1️⃣ Generator

The generator creates 3D models and exports them as `.3d` files.

```bash
# General syntax
./build/generator <primitive> [parameters] <output_file.3d>

# Examples:
./build/generator sphere 1 50 50 sphere.3d
./build/generator torus 0.25 1.5 60 60 torus.3d
./build/generator cometa 1 20 20 42 0.1 cometa.3d
./build/generator patch teapot.patch 10 teapot.3d
```

> **💡 Tip:** You can generate all basic primitives at once using the provided script:
> `./testes_normais/generate_all.sh`

### 2️⃣ Engine

The engine reads an XML configuration file to load and render the scene.

```bash
./build/engine <path_to_scene.xml>
```

---

## 🎬 Demos & Tests

### Solar System Demo 🪐

Experience a complete demonstration featuring planets, textures, orbits using Catmull-Rom curves, and lighting.

```bash
./demo_sistema_solar/run_demo.sh
```

### Phase-Specific Tests 🧪

The project was developed in 4 phases. You can run automated tests for any specific phase using the provided script:

```bash
# Usage: ./run_test.sh <phase_number> <test_number>
./test_files/run_test.sh 1 3
./test_files/run_test.sh 4 1
```

---

## 🗂️ Repository Structure

```
CG/
├── 📁 demo_sistema_solar/    # Complete Solar System demonstration
├── 📁 include/               # Header files (.h)
│   ├── 📁 engine/            # Engine headers (Camera, Group, XML, etc.)
│   └── 📁 generator/         # Generator headers (Primitives, Patches)
├── 📁 src/                   # Source files (.cpp)
│   ├── 📁 engine/            # Engine logic and rendering
│   └── 📁 generator/         # Model generation logic
├── 📁 test_files/            # XML scenes and patches for testing
├── 📁 testes_normais/        # XML scenes for testing
├── 📄 CMakeLists.txt         # Build configuration
└── 📄 README.md              # This file
```

---

## 🎯 Skills Acquired

✅ 3D rendering pipeline understanding  
✅ Shader programming and GPU interaction  
✅ Scene graph architecture design  
✅ Camera systems (orbital & free-look)  
✅ Lighting models (Phong, Blinn-Phong)  
✅ Texture mapping and image-based rendering  
✅ Catmull-Rom spline animation  
✅ Bézier surface tessellation  
✅ VBO-based efficient rendering  
✅ XML-driven scene configuration  

---

## 👥 Authors

**Group 6** - *Computer Graphics Course*

<table>
<tr>
<td align="center">
<a href="https://github.com/CarlosAraujo05">
<img src="https://github.com/CarlosAraujo05.png" width="100px;" alt="CarlosAraujo05"/><br />
<sub><b>CarlosAraujo05</b></sub>
</a>
</td>
<td align="center">
<a href="https://github.com/DelgadoDevT">
<img src="https://github.com/DelgadoDevT.png" width="100px;" alt="DelgadoDevT"/><br />
<sub><b>DelgadoDevT</b></sub>
</a>
</td>
<td align="center">
<a href="https://github.com/PaoComPlanta">
<img src="https://github.com/PaoComPlanta.png" width="100px;" alt="PaoComPlanta"/><br />
<sub><b>PaoComPlanta</b></sub>
</a>
</td>
<td align="center">
<a href="https://github.com/Vitor-Senra">
<img src="https://github.com/Vitor-Senra.png" width="100px;" alt="Vitor-Senra"/><br />
<sub><b>Vitor-Senra</b></sub>
</a>
</td>
</tr>
</table>

---

## 📜 License

Part of UMinho Software Engineering Archives - [Educational Use License](../../../LICENSE)

<div align="center">

**Academic Year:** 2025/2026  
**Course Code:** CG  
**Department:** Informatics Engineering  
**University:** Universidade do Minho

[⬆️ Back to Top](#-cg---computer-graphics)

</div>
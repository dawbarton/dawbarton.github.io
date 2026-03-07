---
title: "Background"
weight: 10
---

## Biography

David A W Barton is Professor of Computational and Experimental Mathematics in the School of Engineering Mathematics and Technology at the University of Bristol. He has spent his entire independent career at Bristol, progressing through Lecturer (2010), Senior Lecturer with accelerated progression (2016), Reader (2018), and Professor (2023). Prior to his independent career he held postdoctoral positions at Bristol — a Lloyds Tercentenary Foundation Fellowship (2006–2007) and a Great Western Research Fellowship (2007–2010) — with a period as International Scholar in Mechanical Engineering and Materials Science at Duke University, USA (2009–2010). He is co-Director of the [Data-Driven Engineering and Sciences](https://engmaths.github.io/ddes-dte/) doctoral training environment in the School of Engineering Mathematics and Technology.

---

My research sits at the boundary of applied mathematics, engineering, and machine learning. The unifying theme is understanding and exploiting the behaviour of **nonlinear dynamical systems** — from aircraft wings and robotic fingers to biological cells and power converters — using a combination of mathematical theory, numerical methods, and data-driven approaches.

## Research vision

Physical systems are almost always nonlinear, yet most analytical and computational tools have been built around linear approximations. My group develops methods that take nonlinearity seriously: techniques that can characterise, predict, and control rich nonlinear behaviour in systems that are too complex to model from first principles alone. Increasingly, this means combining physics-based models with machine learning — an approach now called **scientific machine learning (SciML)** — to get the best of both worlds.

A distinctive strand of this programme is working directly with physical experiments rather than simulations. This is harder, but it ensures that the methods we develop actually work in the presence of noise, uncertainty, and unmodelled dynamics.

## Control-based continuation

One of my principal contributions is the development and application of **control-based continuation (CBC)**, a technique for tracing the nonlinear dynamic properties of a physical experiment directly — without needing a mathematical model of the system. CBC uses feedback control to stabilise otherwise unstable periodic or quasi-periodic responses, allowing the full solution structure (including unstable branches) to be mapped out experimentally. This gives experimentalists access to the same bifurcation diagrams that theorists take for granted, but measured from the real system rather than inferred from a model.

CBC has been applied to nonlinear oscillators, aeroelastic flutter in wind-tunnel experiments, and a range of other structural and mechanical systems. Current work extends it to multi-degree-of-freedom systems and integrates machine-learning-based surrogate models to reduce the experimental effort required.

## Scientific machine learning

SciML seeks to fuse physics-based models (differential equations, conservation laws, known structure) with data-driven methods (Gaussian processes, neural networks, reinforcement learning). Neither pure physics nor pure data science is sufficient for many engineering problems: the physics provides structure and extrapolation ability; the data fills in what the physics cannot capture.

Current projects in this area span neural dynamics, engineering biology, and the design of surrogate models for power electronics. I am also interested in the theoretical underpinnings: uncertainty quantification, out-of-distribution generalisation, and the design of SciML architectures that respect the geometry of the underlying dynamical system.

## Application areas

Research in the group spans several engineering and scientific domains:

- **Aeroelastic flutter** — understanding and controlling whirl flutter in next-generation electric vertical take-off and landing (eVTOL) aircraft, in collaboration with Djamel Rezgui and Mark Lowenberg.
- **Tactile robotics** — online learning for the [TacTip](https://lepora.com/tactip/) optical tactile sensor, enabling robots to learn dexterous manipulation skills with minimal data, in collaboration with [Nathan Lepora](https://lepora.com/).
- **Engineering biology** — applying SciML and agent-based modelling to gene regulatory networks and non-small cell lung cancer, in collaboration with Lucia Marucci.
- **Nuclear fusion materials** — machine learning for predicting material properties under extreme conditions, in collaboration with the [UK Atomic Energy Authority](https://www.gov.uk/government/organisations/uk-atomic-energy-authority).
- **Power electronics** — surrogate modelling and optimal design of modular multi-level converters for offshore wind turbines, in collaboration with Ian Laird.

## Selected publications

The papers below give a cross-section of the main research themes. For a full list see my **[Google Scholar page](https://scholar.google.co.uk/citations?user=9lxSeYMAAAAJ&hl=en)**, [ORCID](https://orcid.org/0000-0002-0595-4239), or [ResearchGate](https://www.researchgate.net/profile/David-Barton-7).

**Control-based continuation — method and stability**

Barton, D.A.W. (2017). Control-based continuation: bifurcation and stability analysis for physical experiments. *Mechanical Systems and Signal Processing*, 84, 54–64. [[Bristol portal]](https://research-information.bris.ac.uk/en/publications/control-based-continuation-bifurcation-and-stability-analysis-for)

**CBC with Gaussian process regression**

Renson, L.; Sieber, J.; Barton, D.; Shaw, A.; Neild, S. (2019). Numerical continuation in nonlinear experiments using local Gaussian process regression. *Nonlinear Dynamics*. [[Bristol portal]](https://research-information.bris.ac.uk/en/publications/numerical-continuation-in-nonlinear-experiments-using-local-gauss)

**Scientific machine learning for experimental bifurcation analysis**

Beregi, S.; Barton, D.A.W.; Rezgui, D.; Neild, S. (2022). Using scientific machine learning for experimental bifurcation analysis of dynamic systems. *Mechanical Systems and Signal Processing*. [[Bristol portal]](https://research-information.bris.ac.uk/en/publications/using-scientific-machine-learning-for-experimental-bifurcation-an)

**Hybrid mechanistic–ML modelling**

Lee, K.H.; Barton, D.A.W.; Renson, L. (2023). Modelling of physical systems with a Hopf bifurcation using mechanistic models and machine learning. *Mechanical Systems and Signal Processing*.

**Tactile robotics — in-hand dexterous manipulation**

Yang, M.; Lu, C.; Church, A.; Lin, Y.; Ford, C.; Li, H.; Psomopoulou, E.; Barton, D.; Lepora, N. (2024). AnyRotate: Gravity-invariant in-hand object rotation with sim-to-real touch. *Conference on Robot Learning (CoRL)*. [[arXiv]](https://arxiv.org/abs/2405.07391)

**Neural context flows for generalizable dynamical systems**

Nzoyem, R.D.; Barton, D.A.W.; Deakin, T. (2024). Neural context flows for learning generalizable dynamical systems. *arXiv preprint*.

## Funding

My research has been supported by the [Engineering and Physical Sciences Research Council (EPSRC)](https://www.ukri.org/councils/epsrc/), including the Programme Grant *Digital twins for improved dynamic design* (EP/R006768/1) and the Responsive-Mode Grant *Next-generation test methods for nonlinear structures* (EP/P019323/1), as well as EPSRC Doctoral Training Partnerships, the [Interactive AI Centre for Doctoral Training](https://www.bristol.ac.uk/cdt/interactive-ai/), and the [Chinese Scholarship Council](https://www.csc.edu.cn/). Industrial collaborations have also contributed to project funding.

## Research specialities

- Mathematical modelling (engineering, biosciences, neuroscience)
- Dynamics and control of nonlinear systems
- Numerical methods for dynamical systems (particularly bifurcation analysis and numerical continuation)
- Systems with delay (delay differential equations)
- Scientific machine learning (Gaussian processes, neural networks, reinforcement learning)
- Control-based continuation for physical experiments
- Uncertainty quantification for dynamical systems

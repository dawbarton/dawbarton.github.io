---
title: "Background"
weight: 10
---

## Biography

David A W Barton is Professor of Computational and Experimental Mathematics in the School of Engineering Mathematics and Technology at the University of Bristol (appointed 2023) and co-Director of the [Data-Driven Engineering and Sciences](https://engmaths.github.io/ddes-dte/) doctoral training environment. He received his PhD from the University of Bristol in 2006, followed by postdoctoral fellowships as a Lloyds Tercentenary Foundation Fellow (2006–2007) and Great Western Research Fellow (2007–2010) at Bristol, with a period as International Scholar in Mechanical Engineering and Materials Science at Duke University, USA (2009–2010). He was appointed Lecturer in 2010, Senior Lecturer in 2016, and Reader in 2018.

---

My research sits at the boundary of applied mathematics, engineering, and machine learning. The unifying theme is understanding and exploiting the behaviour of **nonlinear dynamical systems** using a combination of mathematical theory, numerical methods, and data-driven approaches. I work across a wide range of application areas from aircraft wings and robotic fingers to biological cells and power converters.

## Research vision

Physical systems are almost always nonlinear, yet most analytical and computational tools have been built around linear approximations. My group develops methods that take nonlinearity seriously: techniques that can characterise, predict, and control rich nonlinear behaviour in systems that are too complex to model from first principles alone. Increasingly, this means combining physics-based models with machine learning to get the best of both worlds &mdash; an approach now called **scientific machine learning (SciML)**.

A distinctive strand of this programme is working directly with physical experiments rather than simulations. This is harder, but it ensures that the methods we develop actually work in the presence of noise, uncertainty, and unmodelled dynamics.

## Control-based continuation

One of my principal contributions is the development and application of **control-based continuation (CBC)**, a technique for tracing the nonlinear dynamic properties of a physical experiment directly without needing a mathematical model of the system. CBC uses feedback control to stabilise otherwise unstable periodic or quasi-periodic responses, allowing the full solution structure (including unstable branches) to be mapped out experimentally. This gives experimentalists access to the same bifurcation diagrams that theorists take for granted, but measured from the real system rather than inferred from a model.

CBC has been applied to nonlinear oscillators, aeroelastic flutter in wind-tunnel experiments, and a range of other structural and mechanical systems. Other researchers have built on my work to bring CBC to biological systems and fluid flow problems. Current work extends it to multi-degree-of-freedom systems and integrates machine-learning-based surrogate models to reduce the experimental effort required.

## Scientific machine learning

SciML seeks to fuse physics-based models (differential equations, conservation laws, known structure) with data-driven methods (Gaussian processes, neural networks, and reinforcement learning). Neither pure physics nor pure data science is sufficient for many engineering problems: the physics provides structure and extrapolation ability; the data fills in what the physics cannot capture.

Current projects in this area span neural dynamics, engineering biology, and the design of surrogate models for power electronics. I am also interested in the theoretical underpinnings: uncertainty quantification, out-of-distribution generalisation, and the design of SciML architectures that respect the geometry of the underlying dynamical system.

## Application areas

Research in the team spans several engineering and scientific domains; below are some recent examples.

- **Flutter in aerospace structures** — understanding and controlling whirl flutter in next-generation electric vertical take-off and landing (eVTOL) aircraft, in collaboration with [Djamel Rezgui](https://www.bristol.ac.uk/people/person/Djamel-Rezgui-4bd70978-04ba-43d5-a4ee-bda3d6f808a3/) and [Mark Lowenberg](https://www.bristol.ac.uk/people/person/Mark-Lowenberg-69b1ce63-ca79-437c-92e5-d01fb7c0a4fa/).
- **Tactile robotics** — online learning for the [TacTip](https://lepora.com/tactip/) optical tactile sensor, enabling robots to learn dexterous manipulation skills with minimal data, in collaboration with [Nathan Lepora](https://lepora.com/) and [Efi Psomopoulou](https://efipsom.github.io).
- **Mathematical and engineering biology** — applying SciML and agent-based modelling to gene regulatory networks and non-small cell lung cancer, in collaboration with [Lucia Marucci](https://www.bristol.ac.uk/people/person/Lucia-Marucci-8de3a95c-6f5e-4c4a-9850-cba01fd70edd/).
- **Nuclear fusion materials** — machine learning for predicting material properties under extreme conditions, in collaboration with the [Burcu Tasdemir](https://www.bristol.ac.uk/people/person/Burcu-Tasdemir-be8e7384-6a55-4e44-8a23-609680d97094/) and the [UK Atomic Energy Authority](https://www.gov.uk/government/organisations/uk-atomic-energy-authority).
- **Power electronics** — surrogate modelling and optimal design of modular multi-level converters for offshore wind turbines, in collaboration with [Ian Laird](https://www.bristol.ac.uk/people/person/Ian-Laird-d6503906-c926-4b09-87d9-481f5a3fef32/).

## Selected publications

The papers below give a cross-section of the main research themes. For a full list see my **[Google Scholar page](https://scholar.google.co.uk/citations?user=9lxSeYMAAAAJ&hl=en)**, [ORCID](https://orcid.org/0000-0002-0595-4239), or [ResearchGate](https://www.researchgate.net/profile/David-Barton-7).

**Control-based continuation — method and stability**

Barton, D.A.W. (2017). Control-based continuation: bifurcation and stability analysis for physical experiments. *Mechanical Systems and Signal Processing*, 84, 54–64. [[Bristol portal]](https://research-information.bris.ac.uk/en/publications/control-based-continuation-bifurcation-and-stability-analysis-for)

**CBC with Gaussian process regression**

Renson, L.; Sieber, J.; Barton, D.; Shaw, A.; Neild, S. (2019). Numerical continuation in nonlinear experiments using local Gaussian process regression. *Nonlinear Dynamics*. [[arXiv]](https://arxiv.org/abs/1901.06970)

**Scientific machine learning for experimental bifurcation analysis**

Beregi, S.; Barton, D.A.W.; Rezgui, D.; Neild, S. (2022). Using scientific machine learning for experimental bifurcation analysis of dynamic systems. *Mechanical Systems and Signal Processing*. [[arXiv]](https://arxiv.org/abs/2110.11854)

**Hybrid mechanistic–ML modelling**

Lee, K.H.; Barton, D.A.W.; Renson, L. (2023). Modelling of physical systems with a Hopf bifurcation using mechanistic models and machine learning. *Mechanical Systems and Signal Processing*. [[arXiv]](https://arxiv.org/abs/2209.06910)

**Tactile robotics — in-hand dexterous manipulation**

Yang, M.; Lu, C.; Church, A.; Lin, Y.; Ford, C.; Li, H.; Psomopoulou, E.; Barton, D.; Lepora, N. (2024). AnyRotate: Gravity-invariant in-hand object rotation with sim-to-real touch. *Conference on Robot Learning (CoRL)*. [[arXiv]](https://arxiv.org/abs/2405.07391)

**Neural context flows for generalizable dynamical systems**

Nzoyem, R.D.; Barton, D.A.W.; Deakin, T. (2025). Neural context flows for meta-learning of dynamical systems. *International Conference on Learning Representations (ICLR)*. [[OpenReview]](https://openreview.net/pdf?id=8vzMLo8LDN)

## Funding

My research has been supported by the [Engineering and Physical Sciences Research Council (EPSRC)](https://www.ukri.org/councils/epsrc/), including the Programme Grant *Digital twins for improved dynamic design* (EP/R006768/1) and various responsive-mode grants. PhD students have been funded by the EPSRC Doctoral Training Partnership as well as the [Interactive AI Centre for Doctoral Training](https://www.bristol.ac.uk/cdt/interactive-ai/), and the [Chinese Scholarship Council](https://www.csc.edu.cn/). Industrial collaborations have also contributed to PhD funding.

## Research specialities

- Mathematical modelling (engineering, biosciences, and neuroscience)
- Dynamics and control of nonlinear systems
- Numerical methods for dynamical systems (particularly bifurcation analysis and numerical continuation)
- Systems with delay (delay differential equations)
- Scientific machine learning (Gaussian processes, neural networks, and reinforcement learning)
- Control-based continuation for physical experiments
- Uncertainty quantification for dynamical systems

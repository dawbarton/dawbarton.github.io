---
title: "Unlocking the potential of PDE-constrained optimal control: a dive into numerical methods"
date: 2023-11-07
tags: ["paper"]
---

An overview of **'A Comparison of Mesh-Free Differentiable Programming and Data-Driven Strategies for Optimal Control under PDE Constraints',** Roussel D. Nzoyem Ngueguin, David A.W. Barton, Tom Deakin, [SC23, Denver, USA](https://sc23.supercomputing.org/)

[Available on arXiv](https://arxiv.org/abs/2310.02286)

> *Editorial note:* I've often intended to create blog posts of papers that I've been involved with but I've never managed to make time to do it. However, in the world of ChatGPT we can automatically (and largely accurately) generate them.
>
> Below are the results of the prompts `Summarise the key points of the attached PDF in 500 words.` followed by `Rewrite the summary above in the form of a blog post describing the paper. Highlight the key contributions and ensure that the key concepts are explained so that a general audience can understand. The tone should be engaging but remain clear and professional with no hyperbole.`

In the realm of computational mathematics, the challenge of optimal control, particularly when bound by the intricate dance of partial differential equations (PDEs), is akin to finding the most efficient path through a complex, ever-changing landscape. The latest work from Roussel D. Nzoyem Ngueguin, David A.W. Barton, and Tom Deakin at the University of Bristol sheds light on this task, evaluating three innovative numerical methods that promise to refine our approach to these problems.

## The Crossroads of Engineering and Mathematics

Optimal control is pivotal in numerous engineering applications, from crafting the aerodynamics of a vehicle to the flow of currents in ocean engineering. It's about making decisions within a system governed by PDEs to achieve the best outcome. The traditional method, known as Direct-Adjoint Looping (DAL), has been a cornerstone in this field. However, the method is not without its challenges, especially when it comes to setting up complex adjoint problems.

## The New Contenders: PINNs and Differentiable Programming

Enter Physics-Informed Neural Networks (PINNs) and Differentiable Programming (DP). PINNs are a product of the deep learning revolution, offering a mesh-free alternative that doesn't rely on the structured grids of traditional methods. They excel in many areas but can stumble when faced with discontinuities or novel scenarios outside their training data.

Differentiable programming, especially when employing Radial Basis Functions (RBFs), is a fresh take on the old problem. Using the discretise-then-optimise approach, DP leverages modern programming libraries like JAX to create frameworks such as Updec. This allows for the direct integration of PDE constraints into the optimization process, streamlining the entire procedure.

![An illustration of the architectures of DAL, PINNs, and DP](./dal-pinn-dp.png#center)

## Putting Methods to the Test: From Laplace to Navier-Stokes

The authors rigorously test these methods on two PDE problems. The first is the Laplace problem, a classic scenario involving potential flow in a square domain. The second is the more complex, fluid-dynamics challenge posed by the Navier-Stokes equations within a channel. In these trials, DP emerged as a particularly effective method, yielding accurate gradients and holding its ground where DAL and PINNs struggled.

## Evaluating the Contenders

In an engaging discussion, the paper compares the time consumption, memory usage, and effectiveness of DAL, PINNs, and DP. DP stands out for its efficiency and ease of setup, although it's noted that it might be a memory hog due to the need to store and optimize computational graphs.

## The Verdict: A Nod to Differentiable Programming

This document is more than just a comparison; it's a beacon for optimal control practitioners. It bridges a gap with the deep learning community, providing a nuanced view of when and how each method should be employed. The thorough benchmarks and critical analyses culminate in a tacit endorsement of DP as a powerful tool for PDE-constrained optimal control problems.

Through this exploration, the authors have not only provided a valuable resource for those immersed in the field but have also opened a dialogue on the convergence of traditional mathematics and cutting-edge computational techniques. This paper serves as an inspiration for further innovation and a testament to the progress in computational mathematics, promising to empower engineers and mathematicians with more effective tools to navigate the complex world of PDEs and optimal control.

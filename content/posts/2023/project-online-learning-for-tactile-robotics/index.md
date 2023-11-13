---
title: "Research project: Online learning for tactile robotics"
date: 2023-11-03
tags: ["potential-project"]
---

> This is a potential research project for new research students. It is intended to be a starting point for discussion/further investigation rather than a complete research plan. If you are interested in working with me, see [opportunities for new researchers](/research/new-researchers/).

*Keywords:* online learning, machine learning, tactile robotics, generative models

Machine learning (ML) equips robots with the ability to learn from and adapt to new environments, enhancing autonomy and efficiency in complex tasks. However, many ML approaches rely on extensive data for training. This heavy reliance on large volumes of data can hamstring a robot's ability to function in dynamic real-world conditions—imagine a robotic assistant in a home struggling to recognize new types of objects because it was trained on a limited set of household items. Such data dependency limits the robots' effectiveness in diverse real-world applications. We seek to overcome this problem in the context of tactile robotics by exploiting generative online learning, enabling robots to learn 'in the moment' and adapt swiftly to the unpredictability of real-world tasks.

Online learning is where new data is continuously integrated into a model as a task is being performed. As such, the performance of the robot increases over time. Joint with Prof Nathan Lepora, I have previously demonstrated a generative online learning approach ([Learning to live life on the edge](https://arxiv.org/abs/1909.05808)) that uses predictions of the tactile sensor output to track the edges of objects. This has been implemented on a robot arm and a quadruped robot.

![A quadruped robot fitted with a tactile sensor](./robot.png#center)

Significant improvements are needed enable this generative online learning approach to be used on both a broader suite of tasks (not just edge following) and within a higher dimensional space (not just a plane). This will require non-trivial generalisation of the current machine learning approach (a Gaussian Process-Latent Variable Model) and exploration of other computationally efficient generative methods. Insights into the geometry of the tasks of interest are likely to be key to creating an effective approach.

This approach to online learning has the potential to greatly expand the use of tactile sensors and enable them to be used in novel contexts, bringing us closer to building robots that can both touch and feel, and interact safely with the environment around them.

If you are interested in working on this or a related project, please email [david.barton@bristol.ac.uk](mailto:david.barton@bristol.ac.uk) with a copy of your CV and a short description of your research interests; we can co-develop a more complete research statement tailored to you. Applications from all backgrounds are encouraged, especially under-represented groups.

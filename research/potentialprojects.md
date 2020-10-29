@def title = "Areas for collaboration"
@def shorttitle = "Collaboration"

Below are a list of areas I'm keen to work on in the future. This isn't an exclusive list &mdash; there are plenty of other things that interest me! Feel free to [get in touch](/) if there is anything that interests you.

The projects below are largely theory based, however if you are interested in doing physical experiments on nonlinear systems it'd be great to hear from you and we can see what the possibilities for working together are.

## Funding for research staff

If you are looking for a Research Associate (post-doc) position, I advertise all my available jobs on [jobs.ac.uk](https://www.jobs.ac.uk/). If you are interested in applying for post-doctoral fellowships jointly with me, do get in touch. I have previously supported (successful) applications for Marie Skłodowska-Curie fellowships and for Royal Academy of Engineering fellowships.

## Funding for research students

Funding for PhD students is quite limited at the moment; the main sources are

* [EPSRC doctoral training partnership (DTPs)](https://epsrc.ukri.org/skills/students/dta/) &mdash; this funding is usually allocated in January each year to start the following October, though sometimes late funding appears. These awards are usually quite restricted in terms of who can apply; see the [EPSRC eligibility page](https://epsrc.ukri.org/skills/students/guidance-on-epsrc-studentships/eligibility/).
* EPSRC doctoral training centres (CDTs) &mdash; these are large centres taking on around 10 students per year. There is typically year of taught material followed by 3 years of research. The CDT most relevant to my research is [FARSCOPE](https://www.farscope.bris.ac.uk/) CDT in robotics; I have previously supervised two PhD students under it.
* [Chinese Scholarship Council](http://www.bristol.ac.uk/fees-funding/awards/china-scholarship-council/) &mdash; relevant for students resident in China only.

## Projects

### SciML and physics-based machine learning

Scientific machine learning is a rapidly growing area that seeks to combine traditional physics-based models with machine learnt models. In traditional physics-based modelling, you rely on expert knowledge to build the complete model (perhaps with some limited parameter fitting to experimental data); the machine learning approach replaces that expert knowledge with large quantities of data (that's an over simplification but broadly correct). A key question is how to find the sweet spot in the middle whereby you make use of your expert knowledge but also include model features that emerge from the data.

### Control-based continuation for physical experiments

Control-based continuation (CBC) is a means for extracting nonlinear dynamical information from physical experiments. It combines dynamical systems ideas with control theory and stochastic dynamics, sometimes with some machine learning to improve the robustness of the approach. Previously we have applied CBC to the analysis of nonlinear oscillators including aero-elastic flutter using wind tunnel experiments to investigate the bifurcations that occur.

### Control and online learning for tactile robotics

Without our sense of touch, humans find it very difficult to perform many manipulation tasks. This suggests that giving robots a sense of touch will open up a wide range of possibilities for robotic manipulation, including allowing them to interact with their environment in visually obscured situations (e.g., smoke-filled rooms). The TacTip is a low-cost high-resolution sensor that can be used in many situations, however generating the required training data to build an appropriate sensor model is time consuming. Instead, the problem can be viewed from a geometrical perspective and constrained in such a way that it becomes feasible to learn a sensor model online with very little prior data. We have demonstrated the effectiveness of this approach in 2 dimensions but would now like to extend it to higher dimensions.

### Stochastic nonlinear dynamics

More on the theory side of things, I'm keen to develop robust tools for dealing with stochastic nonlinear systems. Presently there are very few general approaches, with the most effective approaches being highly problem specific. The aim is to develop general purpose methods, building on the differential equations ecosystem in Julia to investigate stochastic nonlinear systems that undergo bifurcations.

### Numerical methods for dynamical systems

Again, more generally, I am interested in methods for investigating nonlinear systems. For example, numerical continuation is a general purpose approach which could marry well with the differential equations ecosystem in Julia, enabling different problem types to be composed for the continuation of hybrid dynamical systems or manifold continuation (for example). 
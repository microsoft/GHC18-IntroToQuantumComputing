# Introduction

This repository contains materials for the "Introduction to Quantum Computing" workshop at 2018 Grace Hopper Celebration. You can also use it outside of the workshop for self-paced learning, using the theory covered in the "Useful Links" section.

Quantum computing harnesses the laws of nature to enable new types of algorithms, impossible on traditional computers. They are expected to lead to breakthroughs in crucial areas like material and drug discovery.

In this workshop the participants will learn where the power of quantum computing comes from in a hands-on quantum programming tutorial. The participants will implement a quantum algorithm in Q# programming language that is exponentially faster than any deterministic classical algorithm for that problem - Deutsch-Jozsa algorithm.

# Installing and Getting Started

To work on this tutorial, you'll need to install the [Quantum Development Kit](https://docs.microsoft.com/quantum), available for Windows 10, macOS, and for Linux.
Please see the [install guide for the Quantum Development Kit](https://docs.microsoft.com/en-us/quantum/quantum-installconfig) for the detailed instructions. We recommend that you use Visual Studio 2017 or Visual Studio Code to work on the tutorial.

You can also use [Try It Online](https://tio.run/#qs-core) to work on this tutorial without a local Q# setup, but it has a much worse developer experience (no syntax highlight). The pre-populated project can be accessed at https://aka.ms/GHC18-IntroToQuantumComputing. The algorithm template is in the Code section; you can collapse Driver, Header and Footer sections which contain the testing harness for convenience.

### Downloading the Tutorial

If you have Git installed, go on and clone the Microsoft/GHC18-IntroToQuantumComputing repository. From your favorite command line:

```bash
git clone https://github.com/Microsoft/GHC18-IntroToQuantumComputing.git
```

> **TIP**: Both Visual Studio 2017 and Visual Studio Code make it easy to clone repositories from within your development environment.
> See the [Visual Studio 2017](https://docs.microsoft.com/en-us/vsts/git/tutorial/clone?view=vsts&tabs=visual-studio#clone-from-another-git-provider) and [Visual Studio Code](https://code.visualstudio.com/docs/editor/versioncontrol#_cloning-a-repository) documentation for details.

Alternatively, if you don't have Git installed, you can manually download a [standalone copy of the tutorials](https://github.com/Microsoft/GHC18-IntroToQuantumComputing/archive/master.zip).

# Opening the Tutorial

The tutorial contains the template of the algorithm which you will work on and the testing harness used for verifying your code. The project is laid out as below.

```
README.md                           # Tutorial instructions and useful links.
DeutschJozsaAlgorithm/
  DeutschJozsaAlgorithm.sln         # Visual Studio 2017 solution file.
  DeutschJozsaAlgorithm.csproj      # Project file used to build both classical and quantum code.

  Algorithm.qs                      # Q# source code containing the template of the algorithm.
  Oracles.qs                        # Q# source code containing implementations of quantum oracles used for testing your implementation of the algorithm.
  Tests.qs                          # Q# tests that verify your implementation of the algorithm.
  Driver.cs                         # C# source code used to invoke the Q# tests.
  OracleCounterSimulator.cs         # C# source code used to verify that your implementation of the algorithm calls the oracle exactly once.
```

To open the tutorial in Visual Studio 2017, open the `DeutschJozsaAlgorithm.sln` solution file.

To open the tutorial in Visual Studio Code, open the `DeutschJozsaAlgorithm/` folder.
Press Ctrl + Shift + P / ⌘ + Shift + P to open the Command Palette and type "Open Folder" on Windows 10 or Linux or "Open" on macOS.

> **TIP**: Almost all commands available in Visual Studio Code can be found in the Command Palette.
> If you ever get stuck, press Ctrl + Shfit + P / ⌘ + Shift + P and type some letters to search through all available commands.

> **TIP**: You can also launch Visual Studio Code from the command line if you prefer:
> ```bash
> code DeutschJozsaAlgorithm/
> ```


# Working on the Tutorial

Once you have the project open, you can try building it and running it. The test harness calls your implementation of the algorithm on a set of function. Initially the algorithm always classifies the function as constant, so the first two tests will pass and the third one will fail. You will see something like this:

	Testing f(x) = 0 ...
	   Correct!
	Testing f(x) = 1 ...
	   Correct!
	Testing f(x) = x_k ...
	   f(x) = x_0 on 4 qubits identified as constant but it is balanced.

	Deutsch-Jozsa algorithm is incorrect :-(

Once you fill in the correct code in `Algorithm.qs`, the tests should pass. You can rebuild and rerun the tests as often as you wish.

### Visual Studio 2017

1. Build and run the project (Ctrl + F5).
2. Work on the code in the `Algorithms.qs` file.
3. To test your implementation, rebuild the project and run it again.

### Visual Studio Code

1. Press Ctrl + \` / ⌘ + \` to open the integrated terminal.
   The terminal should already start in the project directory, but if not, use `cd` to navigate to the folder containing the `DeutschJozsaAlgorithm.csproj` file.
2. Run `dotnet run` in the integrated terminal.
   This should automatically build the project and run it.
3. Work on the code in the `Algorithms.qs` file.
4. To test your implementation, run `dotnet run` again.

### Try It Online

1. Press Ctrl + Enter to build and run the project. The spinning gear on the top of the window indicates that the project is in the process of building.
2. Work on the code in the Code section.
3. To test your implementation, rebuild the project again.

# Useful Information

### Deutsch-Jozsa Algorithm

This algorithm solves the following problem: you are given a black box (an oracle) that implements a function f: {0, 1}<sup>n</sup> -> {0, 1} (i.e. a function that takes n-bit binary string as input and produces 0 or 1 as output). You are guaranteed that the function is either constant (i.e. returns 0 on all inputs or 1 on all inputs) or balanced (i.e. returns 0 for exactly half of all inputs and 1 for the other half of the inputs). You have to determine whether the function is constant or balanced.

A deterministic classical algorithm for this problem requires 2<sup>n-1</sup> + 1 evaluations of function f in the worst case. The Deutsch-Jozsa quantum algorithm always produces the correct answer using a single evaluation of f.

This algorithm not only demonstrates a profound separation between quantum and classical computing but also illustrates the fundamental properties of quantum algorithms:
* Quantum parallelism allows a quantum computer to evaluate a function f(x) for multiple different values of x simultaneously.
* Due to the properties of measurement this evaluation is not immediately useful, because there is no way to read all the values f(x) at once.
* Quantum interference combines the calculated values of f(x) in a clever way to determine some global property of function f without measuring all individual values.

We will describe the Deutsch-Jozsa algorithm in the first part of the workshop, so we are not giving the full description here. If you want to study this topic in a self-paced manner, here are several nice descriptions of the algorithm:

* [Wikipedia article](https://en.wikipedia.org/wiki/Deutsch%E2%80%93Jozsa_algorithm).
* Nielsen, M. A. & Chuang, I. L. (2010). Quantum Computation and Quantum Information. pp. 34-36.
* [Lecture 5: A simple searching algorithm; the Deutsch-Jozsa algorithm](https://cs.uwaterloo.ca/%7Ewatrous/CPSC519/LectureNotes/05.pdf).


### Q#

* A quick reference sheet for Q# programming language is available [here](./quickref/qsharp-quick-reference.pdf).
* Full Q# documentation is available [here](https://docs.microsoft.com/en-us/quantum/).


### FAQ

Here are several common mistakes that people do when going through this tutorial.

`Q.` What does `ReleasedQubitsAreNotInZeroState` exception mean?

`A.` The compiler requires that all qubits are in the |0⟩ state immediately before deallocation, so that they can be reused and offered to other `using` blocks for allocation. Remember to reset qubits you've allocated to the |0⟩ state in the end of the algorithm; you can use the library function `ResetAll` for doing this.

`Q.` What does `ReturnStatement in a statement that cannot have a return value` compilation error mean?

`A.` The compiler doesn't allow a `return` statement inside a loop. You have to define a variable outside of the loop which holds your return value and update it in the loop.

### Further Reading

We hope you found this tutorial interesting and educational! If you want to learn more about quantum computing and Q# programming, check out [the Quantum Katas](https://github.com/Microsoft/QuantumKatas) project, which contains more tutorials of similar structure.

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

/////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains the template of Deutsch-Jozsa algorithm which you will be working on.
/////////////////////////////////////////////////////////////////////////////////////////////////

namespace Quantum.DeutschJozsaAlgorithm
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    // Inputs:
    //      1) the number of qubits N in the input register for the function f
    //      2) a quantum operation which implements the oracle |x⟩|y⟩ -> |x⟩|y ⊕ f(x)⟩, where
    //         x is N-qubit input register, y is 1-qubit answer register, and f is a Boolean function
    // You are guaranteed that the function f implemented by the oracle is either 
    // constant (returns 0 on all inputs or 1 on all inputs) or 
    // balanced (returns 0 on exactly one half of the input domain and 1 on the other half).
    // Return:
    //      true if the function f is constant 
    //      false if the function f is balanced
    operation DeutschJozsaAlgorithm (N : Int, oracle : ((Qubit[], Qubit) => ())) : Bool {
        body {
            // Create a boolean variable for storing the return value.
            // You'll need to update it later, so it has to be declared as mutable.
            mutable answer = true;

            // Allocate an array of N+1 qubits using the "using" keyword.

            // For convenience, split the allocated array qubits into 
            // an input register x (first N qubits) and an answer register y (last qubit).
            // You can use array slicing or the library function Most to get the first N elements of an array.

            // Prepare the qubits in the proper state before calling the oracle.
            // Newly allocated qubits start in |0⟩ state.

            // Each qubit of the input register has to be in the |+⟩ state.
            // You can use a for loop or the library function ApplyToEach to iterate over the input register.

            // The answer register has to be in the |-⟩ state.

            // Call the oracle.

            // Apply a Hadamard gate to each qubit of the input register.

            // Measure each qubit of the input register in the computational basis using the M operation.
            // If any of the measurement results are One, the function implemented by the oracle is balanced.
            // Note that you can't return the value in the middle of a loop, 
            // you have to update the answer variable using the "set" keyword.

            // Before releasing the qubits make sure they are all in the |0⟩ state.
            // You can use the library function ResetAll which measures the qubits in the register 
            // and applies a correction if necessary.

            return answer;
        }
    }
}

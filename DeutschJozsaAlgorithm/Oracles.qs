// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

/////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains the implementations of the quantum oracles used by Deutsch-Jozsa algorithm.
// You can read more about quantum oracles which implement classical functions
// at https://review.docs.microsoft.com/en-us/quantum/quantum-concepts-10-oracles.
//
// You do not need to modify anything in this file.
// The algorithm on which you'll be working can be found in Algorithms.qs file.
/////////////////////////////////////////////////////////////////////////////////////////////////

namespace Quantum.DeutschJozsaAlgorithm
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    // ------------------------------------------------------------------------------------------
    // Oracle 1. f(x) = 0 (constant)
    operation Oracle_Zero (x : Qubit[], y : Qubit) : () {
        body {
            // Since f(x) = 0 for all values of x, |y ⊕ f(x)⟩ = |y⟩.
            // This means that the operation doesn't need to do any transformation to the inputs.
            // Build the project and run the tests to see that T01_Oracle_Zero_Test test passes.
        }
        adjoint auto;
    }

    // ------------------------------------------------------------------------------------------
    // Oracle 2. f(x) = 1 (constant)
    operation Oracle_One (x : Qubit[], y : Qubit) : () {
        body {
            // Since f(x) = 1 for all values of x, |y ⊕ f(x)⟩ = |y ⊕ 1⟩ = |NOT y⟩.
            // This means that the operation needs to flip qubit y (i.e. transform |0⟩ to |1⟩ and vice versa).
            X(y);
        }
        adjoint auto;
    }

    // ------------------------------------------------------------------------------------------
    // Oracle 3. f(x) = xₖ (i.e., the value of k-th qubit) (balanced)
    operation Oracle_Kth_Qubit (x : Qubit[], y : Qubit, k : Int) : () {
        body {
            AssertBoolEqual(0 <= k && k < Length(x), true, "k should be between 0 and (number of qubits - 1), inclusive");
            CNOT(x[k], y);
        }
        adjoint auto;
    }

    // ------------------------------------------------------------------------------------------
    // Oracle 4. f(x) = 1 if x has odd number of 1s, and 0 otherwise (balanced)
    operation Oracle_OddNumberOfOnes (x : Qubit[], y : Qubit) : () {
        body {
            // f(x) can be represented as x_0 ⊕ x_1 ⊕ ... ⊕ x_(N-1)
            for (i in 0..Length(x)-1) {
                CNOT(x[i], y);
            }
        }
        adjoint auto;
    }

    // ------------------------------------------------------------------------------------------
    // Oracle 5. f(x) = Σᵢ 𝑟ᵢ 𝑥ᵢ modulo 2 for a given bit vector r (scalar product function) (balanced)
    // Note: oracles 3 and 4 are special cases of this oracle.
    operation Oracle_ProductFunction (x : Qubit[], y : Qubit, r : Int[]) : () {
        body {
            AssertIntEqual(Length(x), Length(r), "Arrays x and r should have the same length");

            for (i in 0..Length(x)-1) {
                if (r[i] == 1) {
                    CNOT(x[i], y);
                }
            }
        }
        adjoint auto;
    }

    // ------------------------------------------------------------------------------------------
    // Oracle 6. f(x) = 1 if x has two or three bits (out of three) set to 1, and 0 otherwise  (majority function) (balanced)
    operation Oracle_MajorityFunction (x : Qubit[], y : Qubit) : () {
        body {
            AssertBoolEqual(3 == Length(x), true, "x should have exactly 3 qubits");
            
            // f(x) = (x_0 AND x_1) ⊕ (x_0 AND x_2) ⊕ (x_1 AND x_2)
            CCNOT(x[0], x[1], y);
            CCNOT(x[0], x[2], y);
            CCNOT(x[1], x[2], y);
        }
        adjoint auto;
    }
}

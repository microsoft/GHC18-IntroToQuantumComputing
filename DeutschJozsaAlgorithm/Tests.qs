// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

/////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains the Q# tests that verify the correctness of your implementation.
// You do not need to modify anything in this file.
// The algorithm on which you'll be working can be found in Algorithms.qs file.
/////////////////////////////////////////////////////////////////////////////////////////////////

namespace Quantum.DeutschJozsaAlgorithm
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    // ------------------------------------------------------------------------------------------
    function AssertOracleCallsCount<'T>(count: Int, oracle: 'T) : () { }
    
    // ------------------------------------------------------------------------------------------
    function ResetOracleCallsCount() : () { }

    // ------------------------------------------------------------------------------------------
    function ConstantOrBalanced (value : Bool) : String {
        if (value) {
            return "constant";
        }
        return "balanced";
    }

    // ------------------------------------------------------------------------------------------
    operation CheckAlgorithmOnOneTest (N : Int, oracle : ((Qubit[], Qubit) => ()), expected : Bool, extraInfo : String) : Bool {
        body {
            ResetOracleCallsCount();
            let actual = DeutschJozsaAlgorithm(N, oracle);
            // check that the return value is correct
            if (actual != expected) {
                let actualStr = ConstantOrBalanced(actual);
                let expectedStr = ConstantOrBalanced(expected);
                Message($"   {extraInfo}identified as {actualStr} but it is {expectedStr}.");
                return false;
            }
            // check that the oracle has been called at most once
            AssertOracleCallsCount(1, oracle);
            return true;
        }
    }

    // ------------------------------------------------------------------------------------------
    operation RunAlgorithmOnTests () : Bool {
        body {
            // constant functions
            Message($"Testing f(x) = 0 ...");
            if (!CheckAlgorithmOnOneTest(4, Oracle_Zero, true, "")) {
                return false;
            }
            Message("   Correct!");

            Message($"Testing f(x) = 1 ...");
            if (!CheckAlgorithmOnOneTest(4, Oracle_One, true, "")) {
                return false;
            }
            Message("   Correct!");

            // balanced functions
            Message($"Testing f(x) = x_k ...");
            for (k in 0..3) {
                if (!CheckAlgorithmOnOneTest(4, Oracle_Kth_Qubit(_, _, k), false, $"f(x) = x_{k} on 4 qubits ")) {
                    return false;
                }
            }
            Message("   Correct!");

            Message($"Testing f(x) = (1 if x has odd number of 1s, and 0 otherwise) ...");
            for (n in 1..4) {
                if (!CheckAlgorithmOnOneTest(n, Oracle_OddNumberOfOnes, false, $"f(x) = (1 if x has odd number of 1s, and 0 otherwise) on {n} qubits ")) {
                    return false;
                }
            }
            Message("   Correct!");

            Message($"Testing f(x) = scalar product function ...");
            if (!CheckAlgorithmOnOneTest(3, Oracle_ProductFunction(_, _, [1; 0; 1]), false, "f(x) = scalar product function for r = [1; 0; 1] ")) {
                return false;
            }
            if (!CheckAlgorithmOnOneTest(4, Oracle_ProductFunction(_, _, [0; 1; 1; 0]), false, "f(x) = scalar product function for r = [0; 1; 1; 0] ")) {
                return false;
            }
            Message("   Correct!");

            Message($"Testing f(x) = majority function ...");
            if (!CheckAlgorithmOnOneTest(3, Oracle_MajorityFunction, false, "")) {
                return false;
            }
            Message("   Correct!");

            return true;
        }
    }

}

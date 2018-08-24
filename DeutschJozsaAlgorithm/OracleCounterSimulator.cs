// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

/////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains parts of the testing harness. 
// You do not need to modify anything in this file.
// The algorithm on which you'll be working can be found in Algorithms.qs file.
/////////////////////////////////////////////////////////////////////////////////////////////////

using System;
using System.Diagnostics;
using System.Collections.Generic;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.DeutschJozsaAlgorithm
{
    /// <summary>
    ///     This custom quantum simulator keeps track of the number of times 
    ///     each operation is executed, by providing a custom native operation: 
    ///     `AssertOracleCallsCount` which asserts the number of times
    ///     the given oracle (operation) has been called.
    /// </summary>
    public class OracleCounterSimulator : QuantumSimulator
    {
        private Dictionary<ICallable, int> _operationsCount = new Dictionary<ICallable, int>();

        public OracleCounterSimulator(
            bool throwOnReleasingQubitsNotInZeroState = true,
            uint? randomNumberGeneratorSeed = null,
            bool disableBorrowing = false) :
            base(throwOnReleasingQubitsNotInZeroState, randomNumberGeneratorSeed, disableBorrowing)
        {
            this.OnOperationStart += CountOperationCalls;
        }

        /// <summary>
        /// Callback method for the OnOperationStart event.
        /// </summary>
        public void CountOperationCalls(ICallable op, IApplyData data)
        {
            if (_operationsCount.ContainsKey(op))
            {
                _operationsCount[op]++;
            }
            else
            {
                _operationsCount[op] = 1;
            }
        }

        // Custom Native operation to reset the oracle counts back to 0.
        public class ResetOracleCallsImpl : ResetOracleCallsCount
        {
            OracleCounterSimulator _sim;

            public ResetOracleCallsImpl(OracleCounterSimulator m) : base(m)
            {
                _sim = m;
            }

            public override Func<QVoid, QVoid> Body => (__in) =>
            {
                _sim._operationsCount.Clear();
                return QVoid.Instance;
            };
        }

        // Custom Native operation to Assert the number of calls for an Operation.
        public class AssertOracleCallsImpl<T> : AssertOracleCallsCount<T>
        {
            OracleCounterSimulator _sim;

            public AssertOracleCallsImpl(OracleCounterSimulator m) : base(m)
            {
                _sim = m;
            }

            public override Func<(Int64, T), QVoid> Body => (__in) =>
            {
                var (expected, oracle) = __in;

                var op = oracle as ICallable;
                Debug.Assert(op != null);

                var actual = _sim._operationsCount.ContainsKey(op) ? _sim._operationsCount[op] : 0;
                Debug.Assert(expected >= actual, $"   Oracle should be called at most {expected} time(s), and your solution called it {actual} time(s).");

                return QVoid.Instance;
            };
        }
    }
}

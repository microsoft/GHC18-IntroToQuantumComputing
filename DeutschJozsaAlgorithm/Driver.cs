// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

/////////////////////////////////////////////////////////////////////////////////////////////////
// This file contains C# code which runs the tests for your implementation. 
// You do not need to modify anything in this file.
// The algorithm on which you'll be working can be found in Algorithms.qs file.
/////////////////////////////////////////////////////////////////////////////////////////////////

namespace Quantum.DeutschJozsaAlgorithm
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new OracleCounterSimulator()) {
                try
                {
                    var runResult = RunAlgorithmOnTests.Run(sim).Result;
                    System.Console.WriteLine();
                    System.Console.WriteLine("Deutsch-Jozsa algorithm is " + (runResult ? "correct!" : "incorrect :-("));
                }
                catch (System.Exception e) {
                    System.Console.WriteLine("Exception: " + e.InnerException.Message);
                }
                System.Console.WriteLine("Press any key to continue...");
                System.Console.ReadKey();
            }
        }
    }
}
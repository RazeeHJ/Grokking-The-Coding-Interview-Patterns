import UIKit

/// Given an array of positive numbers and a positive number ‘k,’ find the maximum sum of any contiguous subarray of size ‘k’.
///
/// Given an array, find the average of all  subarrays of ‘K’ contiguous elements in it.
/// Input: [1, 3, 2, 6, -1, 4, 1, 8, 2], K=5
/// Output: [2.2, 2.8, 2.4, 3.6, 2.8]

func findAverage(k: Int, arr: [Int]) -> [Double] {
    var windowStart = 0
    var result = Array(repeating: 0.0, count: arr.count-k+1)
    var sum = 0
    
    for windowEnd in 0..<arr.count {
        sum += arr[windowEnd]
        
        if (windowEnd >= k-1) {
            let avg = Double(sum)/Double(k)
            result[windowStart] = avg
            sum -= arr[windowStart]
            windowStart += 1
        }
    }
    
    return result
}

findAverage(k: 5, arr: [1, 3, 2, 6, -1, 4, 1, 8, 2])

/// Problem
/// Maximum Sum Subarray of Size K (easy)
/// Input: [2, 1, 5, 1, 3, 2], k=3
/// Output: 9
/// Explanation: Subarray with maximum sum is [5, 1, 3].
///
/// Input: [2, 3, 4, 1, 5], k=2
/// Output: 7
/// Explanation: Subarray with maximum sum is [3, 4].

/// Solution
/// 1. Subtract the element going out of the sliding window, i.e., subtract the first element of the window.
/// 2. Add the new element getting included in the sliding window, i.e., the element coming right after the end of the window.
///

func findMaxSumSubArray(k: Int, arr: [Int]) -> Int {
    var windowStart = 0
    var windowSum = 0
    var maxSum = 0
    
    for windowEnd in 0..<arr.count {
        windowSum += arr[windowEnd] // add the next element
        
        // Slide the window, no need to slide if we have not hit the window size of 'k'
        if windowEnd >= k - 1 {
            maxSum  = max(maxSum, windowSum)
            windowSum -= arr[windowStart] // subtract the element going out
            windowStart += 1 // slide the window ahead
        }
    }
    
    return maxSum
}

findMaxSumSubArray(k: 3, arr: [2, 1, 5, 1, 3, 2])
findMaxSumSubArray(k: 2, arr: [2, 3, 4, 1, 5])



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

findAverage(k: 5, arr: [1, 3, 2, 6, -1, 4, 1, 8, 2, 5, 5])

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

/// Smallest Subarray with a Greater Sum (easy)
///
/// Example 1
/// Input: [2, 1, 5, 2, 3, 2], S=7
/// Output: 2
/// Explanation: The smallest subarray with a sum greater than or equal to '7' is [5, 2].
///
/// Example 2
/// Input: [2, 1, 5, 2, 8], S=7
/// Output: 1
/// Explanation: The smallest subarray with a sum greater than or equal to '7' is [8].
///
/// Example 3
/// Input: [3, 4, 1, 1, 6], S=8
/// Output: 3
/// Explanation: Smallest subarrays with a sum greater than or equal to '8' are [3, 4, 1] or [1, 1, 6].
///
/// Time Complexity
/// The time complexity of the above algorithm will be O(N)O(N). The outer for loop runs for all elements, and the inner while loop processes each element only once; therefore, the time complexity of the algorithm will be O(N+N)O(N+N), which is asymptotically equivalent to O(N)O(N).
///
/// Space Complexity
/// The algorithm runs in constant space O(1)O(1).

func findMinSubArray(s: Int, arr: [Int]) -> Int {
    var windowStart = 0
    var sum = 0, result = Int.max
    
    for windowEnd in 0..<arr.count {
        sum += arr[windowEnd]
        
        while sum >= s {
            result = Swift.min(result, windowEnd-windowStart+1)
            sum -= arr[windowStart]
            windowStart += 1
        }
    }
    return result
}

findMinSubArray(s: 7, arr: [2, 1, 5, 2, 3, 2])
findMinSubArray(s: 7, arr: [2, 1, 5, 2, 8])
findMinSubArray(s: 8, arr: [3, 4, 1, 1, 6])

/// Longest Substring with K Distinct Characters (medium)
/// Problem Statement
///
/// Given a string, find the length of the longest substring in it with no more than K distinct characters.
/// You can assume that K is less than or equal to the length of the given string.
///
/// Example 1:
/// Input: String="araaci", K=2
/// Output: 4
/// Explanation: The longest substring with no more than '2' distinct characters is "araa".
///
/// Example 2:
/// Input: String="araaci", K=1
/// Output: 2
/// Explanation: The longest substring with no more than '1' distinct characters is "aa".
///
/// Example 3:
/// Input: String="cbbebi", K=3
/// Output: 5
/// Explanation: The longest substrings with no more than '3' distinct characters are "cbbeb" & "bbebi".

func findLength(str: String, k: Int) -> Int {
    let arr = Array(str)
    var windowStart = 0
    var letters: [Character: Int] = [:]
    var maxLength = 0
    
    for windowEnd in 0..<arr.count {
        if let key = letters[arr[windowEnd]] {
            letters[arr[windowEnd]] = key + 1
        } else {
            letters[arr[windowEnd]] = 1
        }
        
        while letters.count > k {
            if let key = letters[arr[windowStart]] {
                letters[arr[windowStart]] = key - 1
                if key - 1 == 0 {
                    letters[arr[windowStart]] = nil
                }
            }
            windowStart += 1
        }
        
        maxLength = max(maxLength, windowEnd - windowStart + 1)
    }
    
    return maxLength
}

findLength(str: "araaci", k: 2)
findLength(str: "araaci", k: 1)
findLength(str: "cbbebi", k: 3)

/// Fruits into Baskets (medium)
/// Problem Statement
/// You are visiting a farm to collect fruits. The farm has a single row of fruit trees. You will be given two baskets, and your goal is to pick as many fruits as possible to be placed in the given baskets.
/// You will be given an array of characters where each character represents a fruit tree. The farm has following restrictions:
/// Each basket can have only one type of fruit. There is no limit to how many fruit a basket can hold.
/// You can start with any tree, but you can’t skip a tree once you have started.
/// You will pick exactly one fruit from every tree until you cannot, i.e., you will stop when you have to pick from a third fruit type.
/// Write a function to return the maximum number of fruits in both baskets.
///
/// Example 1:
/// Input: Fruit=['A', 'B', 'C', 'A', 'C']
/// Output: 3
/// Explanation: We can put 2 'C' in one basket and one 'A' in the other from the subarray ['C', 'A', 'C']
///
/// Example 2:
/// Input: Fruit = ['A', 'B', 'C', 'B', 'B', 'C']
/// Output: 5
/// Explanation: We can put 3 'B' in one basket and two 'C' in the other basket. This can be done if we start with the second letter: ['B', 'C', 'B', 'B', 'C']
///

func findLength(arr: [Character]) -> Int {
    var windowStart = 0
    var basket: [Character: Int] = [:]
    var maxLength = 0

    for i in 0..<arr.count {
        if let value = basket[arr[i]] {
            basket[arr[i]] = value + 1
        } else {
            basket[arr[i]] = 1
        }

        while (basket.count > 2) {
            if let value = basket[arr[windowStart]] {
                basket[arr[windowStart]] = value - 1

                if value - 1 == 0 {
                    basket[arr[windowStart]] = nil
                }
            }

            windowStart += 1
        }
        print(basket)
        maxLength = max(maxLength, i - windowStart + 1)
    }

    return maxLength
}

/// Time Complexity
/// The above algorithm’s time complexity will be O(N), where ‘N’ is the number of characters in the input array. The outer 'for' loop runs for all characters, and the inner 'while' loop processes each character only once; therefore, the time complexity of the algorithm will be O(N+N), which is asymptotically equivalent to O(N).
/// Space Complexity
/// The algorithm runs in constant space O(1)O(1) as there can be a maximum of three types of fruits stored in the frequency map.
///
/// Similar Problems
/// Problem 1: Longest Substring with at most 2 distinct characters
/// Given a string, find the length of the longest substring in it with at most two distinct characters.
///

// findLength(arr: ["A", "B", "C", "B", "B", "C"])

/// Longest Substring with Distinct Characters (hard)
/// Problem Statement
/// Given a string, find the length of the longest substring, which has all distinct characters.
///
/// Example 1:
/// Input: String="aabccbb"
/// Output: 3
/// Explanation: The longest substring with distinct characters is "abc".
///
/// Example 2:
/// Input: String="abbbb"
/// Output: 2
/// Explanation: The longest substring with distinct characters is "ab".
///
/// Example 3:
/// Input: String="abccde"
/// Output: 3
/// Explanation: Longest substrings with distinct characters are "abc" & "cde".

func findLength(arr: [Character]) -> Int {
    var windowStart = 0
    var dict: [Character: Int] = [:]
    var maxLength = Int.min
    
    for i in 0..<arr.count {
        let rightChar = arr[i]
        if let indx = dict[rightChar] {
            windowStart = max(windowStart, indx + 1)
        }
        
        dict[rightChar] = i
        maxLength = max(maxLength, i-windowStart+1)
    }
    return maxLength
}

findLength(arr: ["a","a","b","c","c","b","b"])
findLength(arr: ["a","b","b","b","b"])
findLength(arr: ["a","b","c","c","d","e"])

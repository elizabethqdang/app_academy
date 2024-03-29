const getDigitFrom = (num, place) => Math.floor(Math.abs(num) / Math.pow(10, place)) % 10;;

const getIntLength = (num) => (num === 0) ? 1 : Math.floor(Math.log10(Math.abs(num))) + 1;

function getMaxDigits(nums) {
	let maxDigits = 0;
	for (let i = 0; i < nums.length; i++) {
		maxDigits = Math.max(maxDigits, getIntLength(nums[i]));
	}
	return maxDigits;
}

// function radixSort(arr) {
// 	// const GetInTLength = (num) => (num === 0) ? 1 : Math.floor(Math.log10(Math.abs(num))) + 1;

// 	if (!Array.isArray(arr)) return null;
// 	if (arr.length === 0) return [];
// 	if (arr.length === 1) return arr;

// 	let answer = [];
// 	let maxDigits = getMaxDigits(arr);
// 	for (let k = 0; k < maxDigits; k++) {
// 		let buckets = Array.from({length: 10}, () => []);

// 		for (let i=0; i < arr.length; i++) {
// 			let digit = getDigitFrom(arr[i], k);
// 			buckets[digit].push(arr[i]);
// 		}
// 		answer = [].concat(...buckets);
// 	}
// 	return answer;
// }

function radixSort(arr) {
	if (!Array.isArray(arr)) return null;

	var negatives = arr.filter(item => item < 0);
	var negativeSorted = [];
	if (negatives.length > 0) {
		negativeSorted = radixSort(negatives.map(item => Math.abs(item)))
		.reverse()
		.map(item => -item);
	}

	var positives = arr.filter(item => item >= 0);
	let maxDigits = getMaxDigits(positives);

	for (let k = 0; k < maxDigits; k++) {
		let buckets = Array.from({length: 10}, () => []);

		for (let i =0; i < positives.length; i++) {
			let digit = getDigitFrom(positives[i], k);
			buckets[digit].push(positives[i]);
		}
		positives = [].concat(...buckets);
	}
	return negativeSorted.concat(positives);
	}


module.exports = {
    radixSort
};
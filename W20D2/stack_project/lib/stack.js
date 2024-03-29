// ============================================================================
// Implementation Exercise: Stack
// ============================================================================
//
// -------
// Prompt:
// -------
//
// Implement a Stack and all of its methods below!
//
// ------------
// Constraints:
// ------------
//
// Make sure the time and space complexity of each is equivalent to those 
// in the table provided in the Time and Space Complexity Analysis section
// of your Stack reading!
//Data Structure Operation	Time Complexity (Avg)	Time Complexity (Worst)	Space Complexity (Worst)
// Access	Θ(n)	O(n)	O(n)
// Search	Θ(n)	O(n)	O(n)
// Insertion	Θ(1)	O(1)	O(n)
// Deletion	Θ(1)	O(1)	O(n)
// -----------
// Let's Code!
// -----------

class Node {
	constructor(val) {
		this.value = val;
		this.next = null;
	}
}

class Stack {
	constructor() {
		this.top = null;
		this.bottom = null;
		this.length = 0;
	}

	push(val) {
		const newNode = new Node(val);
		if (!this.top) {
			this.top = newNode;
			this.bottom = newNode;
		} else {
			const temp = this. top;
			this.top = newNode;
			this.top.next = temp;
		}
		return ++this.length;
	}

	pop() {
		if (!this.top) return null;

		const temp = this.top;
		if (this.top === this.bottom) {
			this.bottom = null;
		}

		this.top = this.top.next;
		this.length--;
		return temp.value;
	}

	size() {
		return this.length;
	}
}

exports.Node = Node;
exports.Stack = Stack;

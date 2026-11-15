# LESSON 2 — Verilog Operators and Expressions



---

## 1. Operator kya hota hai?

An operator is a symbol that specifies an operation to be performed on one or more operands.

Example:

```verilog
c = a + b;
```

Here:

- `a`, `b` = Operands
- `+` = Operator
- `a + b` = Expression
- `c` = Destination variable

Operators ko operands ki requirement ke according classify kiya jaata hai.

| Type | Meaning | Example |
| :--- | :--- | :--- |
| Unary | One operand | `~a` |
| Binary | Two operands | `a & b` |
| Ternary | Three operands | `s ? a : b` |

---

## 2. Arithmetic operators

Arithmetic operators perform mathematical operations on operands.

| Operator | Name | Example |
| :--- | :--- | :--- |
| `+` | Addition | `a + b` |
| `-` | Subtraction | `a - b` |
| `*` | Multiplication | `a * b` |
| `/` | Division | `a / b` |
| `%` | Modulus (remainder) | `a % b` |

### Examples

Suppose:

```verilog
reg [3:0] a, b;
reg [3:0] result;
```

Consider:

```verilog
result = a + b;
```

If `a = 4'b0011` and `b = 4'b0010`, the result is `0101`.

Similarly:

- `a - b` performs subtraction.
- `a * b` performs multiplication.
- `a / b` performs division.
- `a % b` produces the remainder.

For example, 7 divided by 2 gives quotient 3 and remainder 1.

Thus:

$$7/2=3,\quad 7\%2=1$$

**Important:** Verilog arithmetic is subject to fixed bit widths. A result that does not fit into its destination width can lose significant bits.

Consider 4-bit values:

$$1111_2+0001_2=10000_2$$

The mathematical answer requires 5 bits. A 4-bit result cannot preserve the fifth bit.

This is called **truncation due to insufficient result width**.

One safe syntax technique is to explicitly extend the operands:

```verilog
wire [4:0] result;
reg  [3:0] a, b;

assign result = {1'b0, a} + {1'b0, b};
```

This is an arithmetic syntax example, not a circuit implementation.

### Important properties

- Addition is commutative: $a+b=b+a$.
- Multiplication is commutative: $a*b=b*a$.
- Subtraction is not commutative.
- Division is not commutative.
- Division by zero produces an undefined/unknown simulation result.

---

## 3. Relational operators

Relational operators compare two operands and determine their relative magnitude.

| Operator | Meaning |
| :--- | :--- |
| `<` | Less than |
| `>` | Greater than |
| `<=` | Less than or equal to |
| `>=` | Greater than or equal to |

Example:

```verilog
a < b
a > b
a <= b
a >= b
```

**Very important:** Relational expressions produce a 1-bit result.

Their result is generally:

- `1` when the relationship is true.
- `0` when the relationship is false.
- `x` when unknown values prevent the comparison from being determined.

Example:

If `a = 4` and `b = 7`:

| Expression | Result |
| :--- | :--- |
| `a < b` | 1 |
| `a > b` | 0 |
| `a <= b` | 1 |
| `a >= b` | 0 |

### Signed versus unsigned comparison

This is an important exam and practical concept.

```verilog
reg [7:0] a;
reg signed [7:0] b;
```

An unsigned vector interprets its bits as a non-negative binary number.

A signed vector uses two's complement representation for negative values.

For example, an 8-bit pattern:

$$11111111_2$$

- Unsigned interpretation = 255.
- Signed two's complement interpretation = -1.

Therefore, signedness can change the result of relational comparisons and arithmetic.

---

## 4. Equality operators

Equality operators determine whether two operands are equal or unequal.

There are four important operators:

| Operator | Name | Function |
| :--- | :--- | :--- |
| `==` | Logical equality | Checks equality |
| `!=` | Logical inequality | Checks inequality |
| `===` | Case equality | Compares including X and Z |
| `!==` | Case inequality | Checks inequality including X and Z |

### A. Logical equality: `==`

```verilog
a == b
```

Returns:

- `1` when equal.
- `0` when unequal.
- `x` when the comparison cannot be determined because of unknown values.

### B. Logical inequality: `!=`

```verilog
a != b
```

Returns the opposite equality result, including an unknown result when appropriate.

### C. Case equality: `===`

This is especially important in Verilog simulation.

Unlike `==`, case equality treats `x` and `z` as actual values that can be compared.

Example:

```verilog
4'b10x1 == 4'b10x1
```

Result: `x`.

But:

```verilog
4'b10x1 === 4'b10x1
```

Result: `1`.

Similarly:

```verilog
4'b10z1 === 4'b10z1
```

Result: `1`.

### D. Case inequality: `!==`

Checks whether two operands differ, including their X and Z positions.

**Important exam distinction:**

| Property | `==`, `!=` | `===`, `!==` |
| :--- | :--- | :--- |
| Compares 0 and 1 | Yes | Yes |
| Handles X and Z | Can produce X | Treats them as comparable values |
| Result | 0, 1 or X | Always 0 or 1 |
| Common application | Design expressions | Simulation and testbench checking |

Remember: Case equality does not mean the Verilog `case` statement. They are different concepts.

---

## 5. Logical operators

Logical operators perform logical operations on operands.

| Operator | Name |
| :--- | :--- |
| `&&` | Logical AND |
| `\|\|` | Logical OR |
| `!` | Logical NOT |

Logical operations produce a **one-bit result**.

### A. Logical AND

`a && b`

| a | b | Result |
| :--- | :--- | :--- |
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

### B. Logical OR

`a || b`

| a | b | Result |
| :--- | :--- | :--- |
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

### C. Logical NOT

`!a`

| a | Result |
| :--- | :--- |
| 0 | 1 |
| 1 | 0 |

### What happens with multi-bit operands?

Consider:

```verilog
reg [3:0] a, b;
```

Suppose:

```verilog
a = 4'b0010;
b = 4'b0100;
```

Then:

```verilog
a && b
```

Result = `1`.

Why? Because both operands represent non-zero values.

But:

```verilog
a || b
```

Also gives `1`.

And:

```verilog
!a
```

Gives `0`, because `a` is non-zero.

The key concept is that logical operators treat an entire vector as a logical condition rather than processing each bit independently.

---

## 6. Bitwise operators

This is one of the most important topics for digital circuit implementation.

**Definition:** Bitwise operators perform the specified operation independently on corresponding bits of the operands.

| Operator | Operation |
| :--- | :--- |
| `&` | Bitwise AND |
| `\|` | Bitwise OR |
| `^` | Bitwise XOR |
| `~` | Bitwise NOT |
| `~^` | Bitwise XNOR |
| `^~` | Bitwise XNOR |

### A. Bitwise AND

```verilog
a & b
```

| a | b | Output |
| :--- | :--- | :--- |
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

### B. Bitwise OR

```verilog
a | b
```

| a | b | Output |
| :--- | :--- | :--- |
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

### C. Bitwise XOR

```verilog
a ^ b
```

| a | b | Output |
| :--- | :--- | :--- |
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

XOR produces 1 when the two bits are different.

### D. Bitwise NOT

```verilog
~a
```

| a | Output |
| :--- | :--- |
| 0 | 1 |
| 1 | 0 |

### E. Bitwise XNOR

```verilog
a ~^ b
```

XNOR produces 1 when the two bits are equal.

| a | b | Output |
| :--- | :--- | :--- |
| 0 | 0 | 1 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

### Multi-bit example

Suppose:

```verilog
a = 4'b1010;
b = 4'b1100;
```

Then:

| Expression | Result |
| :--- | :--- |
| `a & b` | `1000` |
| `a \| b` | `1110` |
| `a ^ b` | `0110` |
| `~a` | `0101` |
| `a ~^ b` | `1001` |

**Extremely important distinction**

Do not confuse logical and bitwise operators.

| Bitwise | Logical |
| :--- | :--- |
| `&` | `&&` |
| `\|` | `\|\|` |
| `~` | `!` |
| Operates bit by bit | Evaluates logical truth |
| Vector result for bitwise binary operations | One-bit result |

Example:

```verilog
4'b1010 & 4'b1100
```

Result: `1000`.

But:

```verilog
4'b1010 && 4'b1100
```

Result: `1`.

This distinction will be extremely useful when writing gates and behavioural conditions.

---

## 7. Reduction operators

This is a separate category, even though it uses some of the same symbols as bitwise operations.

**Definition:** Reduction operators perform an operation across all bits of a single vector and produce a single-bit result.

There are six reduction operators.

| Operator | Name | Function |
| :--- | :--- | :--- |
| `&` | Reduction AND | AND of all bits |
| `~&` | Reduction NAND | NAND of all bits |
| `\|` | Reduction OR | OR of all bits |
| `~\|` | Reduction NOR | NOR of all bits |
| `^` | Reduction XOR | XOR of all bits |
| `~^` or `^~` | Reduction XNOR | XNOR of all bits |

### Example

Suppose:

```verilog
reg [3:0] a;
```

And:

```verilog
a = 4'b1011;
```

Now evaluate:

| Expression | Operation | Result |
| :--- | :--- | :--- |
| `&a` | `1 & 0 & 1 & 1` | 0 |
| `~&a` | `~(1 & 0 & 1 & 1)` | 1 |
| `\|a` | `1 \| 0 \| 1 \| 1` | 1 |
| `~\|a` | `~(1 \| 0 \| 1 \| 1)` | 0 |
| `^a` | `1 ^ 0 ^ 1 ^ 1` | 1 |
| `~^a` | `~(1 ^ 0 ^ 1 ^ 1)` | 0 |

Notice that the number of 1s in `1011` is three, which is odd. Therefore, XOR reduction gives 1.

### Bitwise versus reduction

This difference is crucial:

```verilog
a & b
```

Takes two operands and performs bitwise AND.

```verilog
&a
```

Takes one vector and performs reduction AND.

**Exam definition:** Reduction operators reduce a multi-bit vector to a single-bit result by performing a logical operation across all bits.

We'll use reduction operators when studying parity generators and parity checkers.

---

## 8. Shift operators

Shift operators move bits to the left or right.

There are four operators:

| Operator | Name |
| :--- | :--- |
| `<<` | Logical left shift |
| `>>` | Logical right shift |
| `<<<` | Arithmetic left shift |
| `>>>` | Arithmetic right shift |

### A. Logical left shift

```verilog
a << 1
```

Moves each bit one position to the left.

- Zero is inserted at the right.
- Bits shifted beyond the left boundary are discarded.

Example:

$$00001010 << 1 = 00010100$$

### B. Logical right shift

```verilog
a >> 1
```

Moves bits to the right.

- Zero is inserted at the left.
- Bits shifted beyond the right boundary are discarded.

Example:

$$00001010 >> 1 = 00000101$$

### C. Arithmetic left shift

```verilog
a <<< 1
```

For ordinary Verilog vector values, arithmetic left shift also shifts left and fills zeros on the right, like logical left shift.

### D. Arithmetic right shift

```verilog
a >>> 1
```

This is particularly important for signed binary numbers.

For a signed operand, the sign bit is replicated during right shifting. This is called **sign extension**.

Example:

Suppose we have an 8-bit signed negative number:

$$11110000$$

After arithmetic right shift by one:

$$11111000$$

The most significant bit, which represents the sign, is preserved.

Compare:

**Logical right shift**
- Original: **11110000**
- After `>> 1`: **01111000**

**Arithmetic right shift (signed)**
- Original: **11110000**
- After `>>> 1`: **11111000**

Important condition: The left operand of `>>>` must be signed for sign extension to occur. If it is unsigned, zeros are shifted in.

### Quick comparison

| Feature | Logical shift | Arithmetic shift |
| :--- | :--- | :--- |
| Left shift | Zeros inserted on right | Zeros inserted on right |
| Right shift | Zeros inserted on left | Sign bit replicated for signed operands |
| Application | General bit manipulation | Signed arithmetic |

---

## 9. Conditional operator `?:`

This is also known as the **ternary operator** because it requires three operands.

General syntax:

```verilog
condition ? expression1 : expression2;
```

Meaning:

- When condition is true, select expression1.
- When condition is false, select expression2.

Example:

```verilog
assign result = select ? a : b;
```

This represents the selection behaviour of a 2-to-1 multiplexer.

Truth of selection:

| select | result |
| :--- | :--- |
| 0 | b |
| 1 | a |

One special point: When the condition is `x` or `z`, Verilog evaluates both alternatives and merges their bit values. Matching bits remain known; differing bits become `x`.

This is useful to know for four-state simulation.

---

## 10. Concatenation operator `{}`

Concatenation combines multiple vectors or bits into a single larger vector.

**Definition:** The concatenation operator combines two or more operands into one bit vector, preserving their specified order.

Syntax:

```verilog
{expression1, expression2, expression3}
```

Example:

```verilog
reg [3:0] a, b;
wire [7:0] result;

assign result = {a, b};
```

Suppose:

```verilog
a = 4'b1010;
b = 4'b1100;
```

Then:

$$\{a,b\}=10101100$$

Here:

- `a` becomes the upper 4 bits.
- `b` becomes the lower 4 bits.
- Total width = 8 bits.

**Visual representation:**

- Operand `a`: **1010**
- Operand `b`: **1100**
- Combined 8-bit vector: **10101100**

Concatenation is useful for:

- Combining multiple input fields.
- Constructing wider vectors.
- Extending bit widths.
- Manipulating data in shift registers.

---

## 11. Replication operator

Replication is related to concatenation.

**Definition:** The replication operator repeats a bit pattern a specified number of times to create a larger vector.

Syntax:

```verilog
{number_of_repetitions{expression}}
```

Examples:

```verilog
{4{1'b0}}
```

Result:

$$0000$$

Another example:

```verilog
{3{2'b10}}
```

Result:

$$101010$$

Here, the 2-bit pattern `10` is repeated three times.

Difference:

| Concatenation | Replication |
| :--- | :--- |
| Combines operands | Repeats an operand |
| `{a,b}` | `{4{a}}` |
| Width is the sum of operand widths | Width is repetitions × operand width |

Replication is particularly useful for initializing or extending vectors.

---

## 12. Bit selection and part selection

These are extremely important for practical implementation.

### A. Bit selection

Extracts one individual bit from a vector.

```verilog
data[3]
```

Means the fourth bit from the right if indexing starts at zero.

### B. Part selection

Extracts a range of bits.

```verilog
data[7:4]
```

Extracts four bits: positions 7, 6, 5 and 4.

**Example: `data[7:0]`**

```text
Bit position:   7   6   5   4   3   2   1   0
              |---data[7:4]---|---data[3:0]---|
```

Verilog-2001 also supports indexed part-select:

```verilog
data[0 +: 4]
data[7 -: 4]
```

Both select four bits in this example, but specify the starting position and direction differently.

---

## 13. Operator precedence

Now comes a very important examination topic.

**Definition:** Operator precedence determines the order in which operators are evaluated within an expression.

Consider:

```verilog
a + b * c
```

Multiplication has higher precedence than addition.

Therefore, it is evaluated as:

$$a+(b*c)$$

Not:

$$(a+b)*c$$

### Verilog operator precedence table

Highest precedence at the top, lowest at the bottom.

| Priority | Operators | Category |
| :--- | :--- | :--- |
| 1 | `+ - ! ~ & ~& \| ~\| ^ ~^ ^~` | Unary |
| 2 | `* / %` | Multiplicative |
| 3 | `+ -` | Additive |
| 4 | `<< >> <<< >>>` | Shift |
| 5 | `< <= > >=` | Relational |
| 6 | `== != === !==` | Equality |
| 7 | `&` | Bitwise AND |
| 8 | `^ ~^ ^~` | Bitwise XOR/XNOR |
| 9 | `\|` | Bitwise OR |
| 10 | `&&` | Logical AND |
| 11 | `\|\|` | Logical OR |
| 12 | `?:` | Conditional |

### Example 1

```verilog
a + b * c
```

Equivalent to:

```verilog
a + (b * c)
```

### Example 2

```verilog
a | b & c
```

Equivalent to:

```verilog
a | (b & c)
```

### Example 3

```verilog
!a && b
```

The unary NOT is evaluated before logical AND:

```verilog
(!a) && b
```

**My recommendation:** During practical coding, use parentheses even when you know precedence. It makes expressions much easier to read and debug.

---

## 14. Expression sizing and signedness

This is a slightly advanced but extremely useful part of Verilog.

The size of a Verilog expression depends on the sizes and types of its operands and on the applicable expression-sizing rules.

You must understand these basic rules:

| Expression | Result width |
| :--- | :--- |
| Unary bitwise operation | Operand width |
| Reduction operation | 1 bit |
| Relational operation | 1 bit |
| Equality operation | 1 bit |
| Logical operation | 1 bit |
| Shift operation | Left operand width |
| Concatenation | Sum of operand widths |
| Replication | Repetition count × operand width |
| Conditional operator | Determined by its result expressions |

### Unsized constants

For traditional Verilog, an unsized decimal integer literal has at least 32 bits and is signed.

Example:

```verilog
a + 1
```

The constant `1` is an unsized decimal number.

For predictable hardware expressions, use appropriately sized constants:

```verilog
4'd1
1'b1
8'h0F
```

### Signed declaration

```verilog
reg signed [7:0] a;
reg signed [7:0] b;
```

This indicates that the variables use signed representations.

For signed arithmetic, remember:

- Negative numbers are generally represented using two's complement.
- Sign extension preserves the sign when a signed number is widened.
- Unsigned extension inserts zeros.
- Mixing signed and unsigned operands can change expression interpretation.

We will apply this when studying adders, subtractors, comparators and arithmetic circuits.

---

## 15. Assignment symbols: don't confuse them!

This deserves its own section because it is a frequent source of mistakes.

| Symbol | Meaning |
| :--- | :--- |
| `=` | Blocking procedural assignment |
| `<=` | Non-blocking procedural assignment |
| `==` | Logical equality |
| `<=` in a comparison | Less than or equal to |
| `assign` | Continuous assignment keyword |

Examples:

```verilog
a = b;
```

Blocking assignment.

```verilog
a <= b;
```

Non-blocking assignment, when used as a procedural assignment.

```verilog
a <= b
```

Can also be a relational expression meaning a is less than or equal to b, depending on where it appears.

```verilog
assign a = b;
```

Continuous assignment.

**Exam warning:** Do not call `assign` an operator. It is a Verilog keyword used for continuous assignments.

We will study the detailed execution semantics of blocking and non-blocking assignments in the behavioural modelling lesson.

---

## 16. Common exam mistakes

| Incorrect understanding | Correct concept |
| :--- | :--- |
| `&` and `&&` are the same | Bitwise AND and logical AND differ |
| `~` and `!` are the same | Bitwise NOT and logical NOT differ |
| `==` and `===` are the same | Case equality handles X/Z explicitly |
| `reg` always means flip-flop | It is a procedural variable data type |
| `>>>` always performs sign extension | Sign extension requires a signed left operand |
| `<=` always means non-blocking | It can also mean less than or equal to |
| Reduction AND produces a vector | It produces one bit |
| Concatenation repeats a value | Replication repeats a value |

---

## 17. Quick knowledge checkpoint

Don't proceed without testing your understanding. These questions are not circuit implementation questions; they check whether you can use Verilog expressions correctly.

**Operators checkpoint (0/8 answered)**

**Q1. What is the result of `4'b1010 & 4'b1100`?**
- A. `1110`
- B. `1000`
- C. `0001`
- D. `1`

**Q2. What is the width of the expression `&data`, when `data` is an 8-bit vector?**
- A. 8 bits
- B. 4 bits
- C. 1 bit
- D. Depends on data

**Q3. Which operator compares two vectors including their X and Z values?**
- A. `==`
- B. `!=`
- C. `===`
- D. `<=`

**Q4. What is the result of `4'b1010 && 4'b0100`?**
- A. `0000`
- B. `1110`
- C. `1`
- D. `X`

**Q5. Which operator preserves the sign bit while right-shifting a signed operand?**
- A. `<<`
- B. `>>`
- C. `<<<`
- D. `>>>`

**Q6. What is the result of `{3{2'b10}}`?**
- A. `101`
- B. `101010`
- C. `10101010`
- D. `001010`

**Q7. Which operator has higher precedence?**
- A. Logical OR `||`
- B. Bitwise AND `&`
- C. Addition `+`
- D. Equality `==`

**Q8. What does `4'b1011 ^ 4'b0110` produce?**
- A. `1101`
- B. `1010`
- C. `1111`
- D. `0101`

---

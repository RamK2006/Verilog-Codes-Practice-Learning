
# **Verilog HDL – Basic Starter Concept Notes**

These are important for getting started for verilog syntax, iske bina confusion hoga bhot nai aata agr ye to

BEGINNER TO INTERMEDIATE · CONCEPTUAL + PRACTICAL · REVISION GUIDE

## **Chapter 1: Understanding the two types of digital logic**

Before learning Verilog syntax, understand what kind of circuit we are trying to create.

Digital circuits are broadly divided into two categories.

### **1.1 Combinational Logic**

**Definition:** A combinational circuit is a circuit whose output depends only on its present inputs.

It does not remember previous inputs or previous outputs.

[Combinational and Sequential Circuits - GeeksforGeeks](https://images.openai.com/static-rsc-4/ioFzYV7NxQ8iNDhlC6BA74aqEZOmfLysFCNZVei-wqqdh-HLAb67g8WzU7wMvraaUwL80BqCpRMBoYXNOQ6kuVYu3JGyAXHihtajb0tM8nfMnTKlyequruWrMJX1g49ND9dmaWjtUBdL1e9PFuYO1ZgnC_WQ2-GCJQZ9IuifWPM?purpose=inline)

[geeksforgeeks.org](https://www.geeksforgeeks.org/digital-logic/combinational-and-sequential-circuits/?utm_source=chatgpt.com)

Example: AND Gate

\\[ Y=A\cdot B \\]

| A | B | Y |
| - | - | - |
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

If input A or B changes, output Y is recalculated.

**Important characteristics:**

- No memory.
- No clock required.
- Output depends on current inputs.
- Does not store previous states.

**Examples:**

- AND, OR, NOT gates
- Multiplexer (MUX)
- Demultiplexer (DEMUX)
- Half Adder
- Full Adder
- Encoder and Decoder

### **1.2 Sequential Logic**

**Definition:** A sequential circuit is a circuit whose output depends on present inputs as well as its previous stored state.

In simple words, the circuit has memory.

[Electronics Done Quick 7 | Logic Ga | RobotShop Community](https://images.openai.com/static-rsc-4/b2qmocBAN2vWQ99NpatD8C2t2V6BKycPjqNl2yFCw_WMJsrNf_K_FR_YCn4Jy-piJ4OQVD-AgZ3t2t7F6E1HmRzun3pqDMsK1KjEfsQodWCals8WeVXqqLvIIlEJGo8QFJbIfgQGEYU6eGZT4ncIR8K6Hxieqz06eGg9N_xcJPc?purpose=inline)

[community.robotshop.com](https://community.robotshop.com/tutorials/show/electronics-done-quick-7-logic-gates?utm_source=chatgpt.com)

Example: D Flip-Flop

A D Flip-Flop stores the input D at a particular clock edge.

| Clock event | D | Q |
| ----------- | - | - |
| No edge     | 1 | 0 |
| Rising edge | 1 | 1 |
| No edge     | 0 | 1 |
| Rising edge | 0 | 0 |

Notice something important:

When D changes from 1 to 0, Q does not immediately change. It waits for the next rising clock edge.

**Important characteristics:**

- Has memory.
- Stores previous state.
- Commonly uses a clock.
- Output can depend on previous state.

**Examples:**

- Flip-Flop
- Counter
- Register
- Shift Register
- Finite State Machine (FSM)

### **Combinational vs Sequential**

| Feature         | Combinational           | Sequential                    |
| --------------- | ----------------------- | ----------------------------- |
| Memory          | No                      | Yes                           |
| Clock           | Not required            | Commonly required             |
| Depends on      | Present inputs          | Present inputs + stored state |
| Example         | MUX                     | Flip-Flop                     |
| Verilog example | `assign`, `always @(*)` | `always @(posedge clk)`       |

**Remember:** Combinational and Sequential describe the behaviour of a circuit, not the style of writing Verilog code.

## **Chapter 2: What is a Procedural Block?**

Now we come to Verilog programming.

A procedural block is a section of Verilog code in which statements execute procedurally.

There are two main procedural blocks in traditional Verilog:

1. `initial`
2. `always`

### **2.1 Initial Block**

An `initial` block executes once when the simulation starts.

Syntax:

```
initial begin
    statement1;
    statement2;
    statement3;
end
```

Example:

```
module example;

reg a, b, y;

initial begin
    a = 0;
    b = 0;
    y = a & b;
end

endmodule
```

Execution:

1. Simulation starts.
2. `a` becomes 0.
3. `b` becomes 0.
4. `y` becomes 0.
5. The initial block finishes.

**What if inputs change later?**

The block does not automatically execute again.

Example:

```
initial begin
    a = 0;
    #10 a = 1;
    #10 a = 0;
end
```

Here `a` changes because the instructions inside the initial block tell it to change.

It does not mean the initial block is continuously monitoring `a`.

**Where is&#x20;**`initial`**&#x20;used?**

- Testbench stimulus.
- Simulation initialization.
- Initializing certain FPGA resources where supported.

It is generally not used to describe ordinary synthesizable ASIC hardware.

### **2.2 Always Block**

An `always` block repeatedly executes according to its sensitivity list.

Syntax:

```
always @(sensitivity_list) begin
    statements;
end
```

Unlike `initial`, it does not execute just once and finish.

The sensitivity list determines when it executes.

There are three important cases.

**Case A:&#x20;**`always @(*)`

```
always @(*) begin
    y = a & b;
end
```

- `*` means all signals read in the block are included in the sensitivity list.
- If an input changes, the block executes again.
- It generally describes combinational logic.

**Case B:&#x20;**`always @(posedge clk)`

```
always @(posedge clk) begin
    q <= d;
end
```

- `posedge` means positive edge.
- Positive edge means clock changes from 0 to 1.
- The block executes on the rising edge.
- It describes sequential logic such as a positive-edge-triggered flip-flop.

**Case C:&#x20;**`always @(negedge clk)`

```
always @(negedge clk) begin
    q <= d;
end
```

- `negedge` means negative edge.
- Negative edge means clock changes from 1 to 0.
- The block executes on the falling edge.
- It describes sequential logic such as a negative-edge-triggered flip-flop.

[Difference Between Edge Triggering and Level Triggering](https://images.openai.com/static-rsc-4/Hp5BBn23_VEDjduj2P31mmyjZN772p81S_StT6ifimYmxPB6bo2JQaklLTNSsdVTm81032iavgXd5lI7ZLstM8FEmPwnv7bMiRoLkkopypL_tqYCwe6diFzK5CEjlgFKs92GG7jwhNqYyUrpekZMHxdchPgzL93nEYOTDhrR22Y?purpose=inline)

[hackatronic.com](https://hackatronic.com/difference-between-edge-triggering-and-level-triggering/?utm_source=chatgpt.com)

### **Comparison of procedural blocks**

| Block                   | Execution condition      | Typical application |
| ----------------------- | ------------------------ | ------------------- |
| `initial`               | Once at simulation start | Testbench           |
| `always @(*)`           | Changes in read signals  | Combinational       |
| `always @(posedge clk)` | Rising clock edge        | Sequential          |
| `always @(negedge clk)` | Falling clock edge       | Sequential          |

**Most important concept:**

An `always` block does not automatically mean sequential logic.

- `always @(*)` → Combinational.
- `always @(posedge clk)` → Sequential.
- `always @(negedge clk)` → Sequential.

The sensitivity list determines when the block executes and helps determine what hardware is inferred.

## **Chapter 3: Procedural vs Non-Procedural Statements**

This is where many beginners get confused.

First, understand that a procedural block and a procedural assignment are not exactly the same thing.

### **3.1 Procedural Statements**

These are statements written inside procedural blocks such as `initial` and `always`.

Example:

```
always @(*) begin
    y = a & b;
end
```

Here:

- `always` is a procedural block.
- `y = a & b` is a procedural assignment.
- `=` is a blocking assignment.

### **3.2 Continuous Assignment**

Continuous assignment uses the `assign` keyword.

Example:

```
assign y = a & b;
```

It is written outside procedural blocks.

It continuously drives a net based on the expression.

Whenever the input changes, the expression is evaluated again and the net is updated after the relevant simulation scheduling.

### **Procedural vs Continuous Assignment**

| Feature             | Procedural              | Continuous               |
| ------------------- | ----------------------- | ------------------------ |
| Main syntax         | `initial`, `always`     | `assign`                 |
| Assignment location | Inside procedural block | Outside procedural block |
| Execution           | Depends on block/event  | Continuously drives net  |
| Typical LHS         | Variable                | Net                      |
| Example             | `y = a & b;`            | `assign y = a & b;`      |

**Important correction:** Calling continuous assignment the opposite of procedural is a useful beginner shortcut. More precisely, Verilog has procedural blocks and continuous assignments as different language constructs. They are not opposites of combinational and sequential logic.

### **Can both create combinational logic?**

Yes!

**Method 1: Using&#x20;**`assign`

```
wire y;

assign y = a & b;
```

**Method 2: Using&#x20;**`always @(*)`

```
reg y;

always @(*) begin
    y = a & b;
end
```

Both describe an AND function.

They differ in how the behaviour is expressed.

## **Chapter 4: Net Type vs Variable Type**

Verilog has different categories of data objects.

The two important categories are:

1. Net
2. Variable

**Verilog data objects**

**NET TYPES**

Represent connections between circuit elements.

Examples: `wire`, `tri`

**VARIABLE TYPES**

Hold values assigned through procedural statements.

Examples: `reg`, `integer`, `time`

### **4.1 What is a Net?**

A net represents a connection through which a signal is driven.

Example:

```
wire a, b, y;

assign y = a & b;
```

Here, `y` is a net.

A net does not independently store a value like a variable. Its resolved value depends on the drivers connected to it.

Think of it like an electrical connection carrying a signal.

### **4.2 What is a Variable?**

A variable is a data object that can be assigned a value procedurally.

Example:

```
reg a;

initial begin
    a = 0;
    #10 a = 1;
end
```

Here:

- Initially, `a = 0`.
- After 10 time units, `a = 1`.
- The variable retains its last assigned value until it is assigned again.

**Important:** Retaining a value does not automatically mean a physical flip-flop is created. Hardware inference depends on the procedural logic.

## **Chapter 5: Wire vs Reg**

These are among the most frequently used declarations in traditional Verilog.

### **5.1 Wire**

`wire` is a net type.

Example:

```
wire a, b, y;

assign y = a & b;
```

Characteristics:

- Represents a connection.
- Usually driven by `assign` or module outputs.
- Cannot be assigned directly by ordinary procedural assignments in traditional Verilog.
- An undriven wire generally resolves to `Z`.

### **5.2 Reg**

`reg` is a variable type.

Example:

```
reg a, b, y;

always @(*) begin
    y = a & b;
end
```

Characteristics:

- Can be assigned in procedural blocks.
- Retains its last assigned value.
- Does not necessarily create a physical register or flip-flop.
- An uninitialized 4-state reg normally starts as `X` in simulation.

### **Wire vs Reg comparison**

| Feature                                 | Wire        | Reg                              |
| --------------------------------------- | ----------- | -------------------------------- |
| Category                                | Net         | Variable                         |
| Used with `assign`                      | Yes         | No, in traditional Verilog       |
| Procedural assignment                   | No          | Yes                              |
| Holds last assigned value independently | No          | Yes                              |
| Typical use                             | Connections | Procedural outputs and variables |

### **Very important: Does Reg always mean Register?**

**NO!**

This is a very common misconception.

Example 1: Combinational logic using reg

```
reg y;

always @(*) begin
    y = a & b;
end
```

This describes combinational logic, not a flip-flop.

Example 2: Sequential logic using reg

```
reg q;

always @(posedge clk) begin
    q <= d;
end
```

This describes a flip-flop.

So:

- `reg` tells you the Verilog data type.
- `posedge clk` and the assignment behaviour help determine whether a flip-flop is inferred.

## **Chapter 6: Blocking vs Non-Blocking Assignment**

This is another important distinction.

Inside procedural blocks, two common assignment operators are used.

### **6.1 Blocking Assignment (**`=`**)**

Example:

```
always @(*) begin
    a = 1;
    b = a;
end
```

The next statement executes after the previous blocking assignment has updated its value in the current procedural execution.

Here:

1. `a` becomes 1.
2. `b` receives 1.

### **6.2 Non-Blocking Assignment (**`<=`**)**

Example:

```
always @(posedge clk) begin
    a <= 1;
    b <= a;
end
```

The right-hand sides are evaluated and updates are scheduled for the non-blocking assignment region.

Here, `b` receives the old value of `a`, not the newly scheduled value.

### **Comparison**

| Blocking `=`                                | Non-blocking `<=`                                       |
| ------------------------------------------- | ------------------------------------------------------- |
| Updates immediately in procedural execution | Schedules update for later in the current time step     |
| Common in combinational blocks              | Common in sequential blocks                             |
| Statements execute in order                 | Right-hand sides are evaluated before scheduled updates |
| Example: `y = a & b;`                       | Example: `q <= d;`                                      |

**Best practice:**

- Use blocking `=` for combinational procedural logic.
- Use non-blocking `<=` for clocked sequential logic.

## **Chapter 7: How to Write Combinational and Sequential Circuits**

Now let's combine all the concepts.

### **7.1 AND Gate – Continuous Assignment**

```
module and_gate(
    input a,
    input b,
    output wire y
);

assign y = a & b;

endmodule
```

Explanation:

- `a` and `b` are inputs.
- `y` is a net.
- `assign` continuously drives `y`.
- This is combinational logic.

### **7.2 AND Gate – Procedural Assignment**

```
module and_gate(
    input a,
    input b,
    output reg y
);

always @(*) begin
    y = a & b;
end

endmodule
```

Explanation:

- `always @(*)` is a procedural block.
- `y` is declared `reg` because it is assigned procedurally.
- No clock is required.
- This is combinational logic.

### **7.3 D Flip-Flop – Sequential Logic**

```
module d_flipflop(
    input d,
    input clk,
    output reg q
);

always @(posedge clk) begin
    q <= d;
end

endmodule
```

Explanation:

- `posedge clk` detects the rising edge.
- `q` captures `d` on that edge.
- `q` holds its value between clock edges.
- This is sequential logic.

### **7.4 Negative Edge D Flip-Flop**

```
module d_flipflop(
    input d,
    input clk,
    output reg q
);

always @(negedge clk) begin
    q <= d;
end

endmodule
```

This captures the input at the falling edge instead of the rising edge.

### **7.5 Multiplexer – Combinational Logic**

```
module mux(
    input a,
    input b,
    input sel,
    output reg y
);

always @(*) begin
    if (sel == 1'b0)
        y = a;
    else
        y = b;
end

endmodule
```

When `sel = 0`, output is `a`.

When `sel = 1`, output is `b`.

There is no clock and no stored state.

### **7.6 Counter – Sequential Logic**

```
module counter(
    input clk,
    input reset,
    output reg [3:0] count
);

always @(posedge clk) begin
    if (reset)
        count <= 4'b0000;
    else
        count <= count + 1'b1;
end

endmodule
```

Explanation:

- The counter updates at every rising edge.
- Reset sets the counter to zero.
- Otherwise, the stored count increases by one.
- The previous count is used to calculate the next count.

This is sequential logic because the circuit stores its previous state.

## **Chapter 8: What are X and Z in Verilog?**

Verilog uses a four-state logic system.

| Value | Meaning        | Explanation                |
| ----- | -------------- | -------------------------- |
| `0`   | Logic LOW      | Binary zero                |
| `1`   | Logic HIGH     | Binary one                 |
| `X`   | Unknown        | Value cannot be determined |
| `Z`   | High Impedance | No active drive on the net |

### **8.1 X – Unknown**

Example:

```
reg a;

initial begin
    a = 1'bx;
end
```

Output:

```
a = x
```

Common reasons:

- Uninitialized variables.
- Conflicting drivers.
- Unknown simulation values.

### **8.2 Z – High Impedance**

Example:

```
wire out;
reg enable, data;

assign out = enable ? data : 1'bz;
```

When:

- `enable = 1`: output follows `data`.
- `enable = 0`: output is `Z`.

Z represents a high-impedance condition, commonly used for tri-state connections.

### **X vs Z**

| X                           | Z                                   |
| --------------------------- | ----------------------------------- |
| Unknown value               | High impedance                      |
| Cannot determine 0 or 1     | Not actively driven                 |
| Often indicates uncertainty | Often indicates disconnected output |

**Important:** In logic operations, Z is generally treated as an unknown value. For example, `1'b1 & 1'bz` evaluates to X.

## **Chapter 9: Design Module vs Testbench**

This is extremely important when writing Verilog programs.

There are two different modules involved in simulation:

1. Design Module
2. Testbench

### **9.1 Design Module**

The design module describes the actual circuit.

Example: AND Gate

```
module and_gate(
    input a,
    input b,
    output y
);

assign y = a & b;

endmodule
```

This is the circuit that we want to test.

It is also called the DUT (Design Under Test).

### **9.2 Testbench**

A testbench provides input signals to the DUT and checks its outputs.

Example:

```
module tb;

reg a, b;
wire y;

and_gate dut(a, b, y);

initial begin
    a = 0; b = 0;
    #10 a = 0; b = 1;
    #10 a = 1; b = 0;
    #10 a = 1; b = 1;
    #10 $finish;
end

endmodule
```

Let's understand every line.

| Code                | Purpose                        |
| ------------------- | ------------------------------ |
| `reg a, b;`         | Testbench drives input signals |
| `wire y;`           | Receives output from DUT       |
| `and_gate dut(...)` | Instantiates the design        |
| `initial`           | Starts test sequence           |
| `#10`               | Waits 10 simulation time units |
| `$finish`           | Ends simulation                |

### **Why Reg for inputs and Wire for outputs?**

Because the testbench assigns input values inside an `initial` block.

Therefore, it needs variables (`reg`) to drive the DUT inputs.

The output is driven by the DUT, so it is received through a net (`wire`).

[Verilog Testbench Essentials. Creating testbenches in Verilog is an… | by Cleber Moretti | Medium](https://images.openai.com/static-rsc-4/PQPzf0JXv0uARX9u4GCe8q1-BoVr1hToMUaLwkkiRariYTwHk7fMtVhFZAODBcUCOpiUSzjNkqG8H0FcJQSokvTkIxSofJjYVAtRS-ebezXcz4VqiI-hiCZtNn6awUrau6UiDLDrNgN85x9b416_A1iSPVBJdZNC6mFwZubC5PU?purpose=inline)

[medium.com](https://medium.com/%40mcleber/verilog-testbench-essentials-fdf6930b526b?utm_source=chatgpt.com)

**Traditional Verilog testbench rule:**

- Inputs to DUT → Usually `reg`.
- Outputs from DUT → Usually `wire`.

This is a convention for traditional Verilog testbenches, not a universal rule for every possible connection.

## **Chapter 10: How to Identify What to Use in a Question**

When you see a question in an exam or practical, follow this decision process.

### **Step 1: Does the circuit need memory?**

- No → Combinational logic.
- Yes → Sequential logic.

### **Step 2: Which coding style do you want?**

For combinational logic:

**Option A: Continuous assignment**

```
assign y = a | b;
```

**Option B: Procedural assignment**

```
always @(*) begin
    y = a | b;
end
```

For sequential logic:

```
always @(posedge clk) begin
    q <= d;
end
```

### **Step 3: Which data type should you declare?**

Traditional Verilog:

| Situation                           | Declaration |
| ----------------------------------- | ----------- |
| Output driven by `assign`           | `wire`      |
| Output assigned in `always`         | `reg`       |
| Testbench input driver              | `reg`       |
| Testbench output receiver           | `wire`      |
| Clock signal generated in testbench | `reg`       |

## **Chapter 11: Common Mistakes and Important Corrections**

**Mistake 1: Every&#x20;**`always`**&#x20;block creates sequential logic.**

Wrong.

```
always @(*) begin
    y = a & b;
end
```

This is combinational.

**Mistake 2:&#x20;**`reg`**&#x20;always creates a flip-flop.**

Wrong.

`reg` is a Verilog variable type. It does not automatically mean a physical register.

**Mistake 3: Continuous assignment means clock-based calculation.**

Wrong.

```
assign y = a & b;
```

It is not clock-dependent.

**Mistake 4:&#x20;**`initial`**&#x20;automatically runs again whenever an input changes.**

Wrong.

It executes once at simulation start. It only changes values later if its own statements instruct it to do so.

**Mistake 5:&#x20;**`posedge`**&#x20;and&#x20;**`negedge`**&#x20;mean combinational logic.**

Wrong.

They are event controls commonly used to describe edge-triggered sequential logic.

**Mistake 6: Missing an assignment in a combinational block is harmless.**

Wrong.

Example:

```
always @(*) begin
    if (enable)
        y = a;
end
```

When `enable` is 0, `y` is not assigned. It must retain its previous value, which can infer a latch.

Correct combinational version:

```
always @(*) begin
    if (enable)
        y = a;
    else
        y = 0;
end
```

Or assign a default value at the beginning of the block.

## **Chapter 12: One-Page Revision Sheet**

This is the table you should revise before an exam or Verilog practical.

| Concept                  | Meaning                                   | Syntax                  |
| ------------------------ | ----------------------------------------- | ----------------------- |
| Combinational            | Output depends on current inputs          | —                       |
| Sequential               | Output depends on stored state and inputs | —                       |
| Procedural block         | Executes procedural statements            | `initial`, `always`     |
| Continuous assignment    | Continuously drives a net                 | `assign`                |
| Combinational procedural | Executes on input changes                 | `always @(*)`           |
| Positive-edge sequential | Executes on rising clock edge             | `always @(posedge clk)` |
| Negative-edge sequential | Executes on falling clock edge            | `always @(negedge clk)` |
| Net type                 | Represents a connection                   | `wire`                  |
| Variable type            | Holds assigned values                     | `reg`                   |
| Blocking assignment      | Procedural assignment with `=`            | `y = a & b;`            |
| Non-blocking assignment  | Scheduled procedural update               | `q <= d;`               |
| Unknown                  | Unknown logic value                       | `X`                     |
| High impedance           | Undriven/high-impedance state             | `Z`                     |
| Testbench                | Tests the design                          | `module tb;`            |
| DUT                      | Design under test                         | `dut(...)`              |

### **The complete classification**

## **Verilog at a glance**

**DIGITAL CIRCUITS**

**Combinational**

- `assign`
- `always @(*)`
- No memory

**Sequential**

- `always @(posedge clk)`
- `always @(negedge clk)`
- Memory/state

**Verilog coding constructs**

- Procedural blocks: `initial`, `always`
- Continuous assignment: `assign`

**Data object categories**

- Net: `wire`, `tri`
- Variable: `reg`, `integer`, `time`



## **Chapter 13: Two Additional Notes for Accuracy**

**1. Verilog vs SystemVerilog**

In traditional Verilog, `reg` and `wire` are commonly used. SystemVerilog introduces `logic`, which can replace `reg` in many situations and supports more flexible declarations.

For now, focus on traditional Verilog syntax unless your course specifically teaches SystemVerilog.

**2. Clocked logic and latches**

Not every sequential circuit needs a clock. A latch is also a storage element, but it is level-sensitive rather than edge-triggered. The `posedge` and `negedge` examples above describe edge-triggered sequential circuits.

**Final takeaway:**

1. Combinational and Sequential tell you how the circuit behaves.
2. Procedural and Continuous tell you how assignments are written.
3. Net and Variable tell you what kind of data object you are using.
4. Wire and Reg are specific Verilog data types.
5. `initial` and `always` are procedural blocks.
6. `assign` is a continuous assignment.
7. `always @(*)` typically describes combinational logic.
8. `always @(posedge clk)` typically describes sequential logic.


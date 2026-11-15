Verilog ke building blocks ya components:


1. Module : 
Ye sbse basic part hai that means, 
verilog ka building block, other languages ke function jese smjh skte. 
Ek specific hardware function ko implement krna, uski functionality define krne ke liye use krte hai. 
Like, uske input ports, output ports, and uska internal implementation btane ka kaam hota hai iska
Simple bhasha me: har circuit ko hum ek module ke form me describe kar sakte hai.

basic structure:
module module_name (
    input wire a,
    input wire b,
    output wire y
);

    // Internal declarations

    // Circuit description

endmodule
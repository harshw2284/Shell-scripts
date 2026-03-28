<<readme 

Create local_demo.sh with:
1. A function that uses local keyword for variables
2. Show that local variables don't leak outside the function
3. Compare with a function that uses regular variables

readme


#Function with local variable
local_function () {
	local name="local harsh"
	echo "local name is $name"
}

#Function with global variable
global_function() {
	name="global harsh"
	echo "global name is $name"
}

#Function call

# Call local function
local_function


echo "--------------------------------------"

#call global function
global_function




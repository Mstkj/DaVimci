//# include <stdio.h>
# include <iostream>

#if !defined (MESSAGE)
#define MESSAGE "You wish!"
#endif

using namespace std;

auto main(void) -> int {
	std::cout << "Hello, World." << std::endl;
	cin.get();
	printf("Here is the message: %s\n", MESSAGE);
	return 0;
}

// This program is designed to take input from the user
// Below is the standard C hello world program.


/*int main(void) {
	char name[20];
	printf("Enter a name: ");

	scanf("%s", &name); // & is the address-of operator

	printf("Your name is %s\n", name);
}
*/

// Below is the same hello world prorgam written in C++

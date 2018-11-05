---

# 文件和流

>   需包含头文件 <iostream> 和 <fstream>







- ofstream该数据类型表示输出文件流，用于创建文件并向文件写入信息
- ifstream 该数据类型表示输入文件流，用于从文件读取信息
- fstream 该数据类型通常表示文件流，且同时具有 ofstream 和 ifstream 两种功能，这意味着它可以创建文件，向文件写入信息，从文件读取信息
- `ifstream`和`istringstream`是从`istream`中继承来的，继承保证我们在使用`ifstream`和`istringstream`时好像在使用`istream`(`cin`)一样






```cpp
int main () {
	std::fstream file_stream;
	file_stream.open ("test.txt", std::fstream::in | std::fstream::out | std::fstream::app);
	if (file_stream.is_open()){
		std::cout << "fs.open successfully \n";
	}else{
		std::cout << "Error opening file";
	}
	stringstream ss_file_buffer;
	ss_file_buffer << file_stream.rdbuf();
	string s_file_content = ss_file_buffer.str();

	file_stream << " more lorem ipsum";//将输出到file_stream对应的文件中
	file_stream.close();
}
```



#### read

> istream& read (char* s, streamsize n);

- Read block of data
- Extracts n characters from the stream and stores them in the array pointed to by s.


```c++
// read a file into memory
#include <iostream>     // std::cout
#include <fstream>      // std::ifstream

int main () {
	std::ifstream is ("test.txt", std::ifstream::binary);
	if (is) {
		is.seekg (0, is.end);
		int length = is.tellg();// get length of file
		is.seekg (0, is.beg);

		char * buffer = new char [length];

		std::cout << "Reading " << length << " characters... ";
		// read data as a block:
		is.read (buffer,length);//buffer contains the entire file

		if (is)
			std::cout << "all characters read successfully.";
		else
			std::cout << "error: only " << is.gcount() << " could be read";

		is.close();
		delete[] buffer;
	}
}//output:
Reading 640 characters... all characters read successfully.
```

> http://www.cplusplus.com/reference/istream/istream/read/



#### rdbuf



```cpp
#include <iostream>//
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

int main (){
	string file_name("test.txt");//file name
	fstream file_stream;
	file_stream.open(file_name, std::fstream::in);//以仅输入打开文件
	if(!file_stream.is_open()){//if open file end
		cout << "Error opening file!" << endl;
		return;
	}
	stringstream ss_file_buffer;
	ss_file_buffer << file_stream.rdbuf();
	string file_content = ss_file_buffer.str();
	cout << file_content << endl;
	file_stream.close();//file close
}
```








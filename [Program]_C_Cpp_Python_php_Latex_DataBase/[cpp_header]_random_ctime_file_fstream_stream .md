





[TOC]





---

# random

### 正态分布normal_distribution



```cpp
std::default_random_engine generator;
std::normal_distribution<double> distribution(mean, stddev);
double number = distribution(generator);
```



---

# ctime



###### time()



```cpp
	time_t now;
	time(&now);//get current time; same as: 
	now = time(NULL);
```





###### clock

-   Returns the processor time consumed by the program. 返回当前的CPU时间
-   To calculate the actual processing time of a program, the value returned by clock shall be compared to a value returned by a previous call to the same function.
-   若要计算程序实际的执行时间，返回值需要和之前调用同一函数的返回值进行比较

```cpp
#include <stdio.h>//printf
#include <time.h>//clock_t, clock, CLOCKS_PER_SEC
#include <math.h>//sqrt

int frequency_of_primes(int n) {//计算小于等于n的素数的数量
	int i, j;
	int freq = n - 1;
	for (i = 2; i <= n; ++i) {
		for (j = sqrt(i); j > 1; --j) {
			if (i%j == 0) {
				--freq;
				break;
			}
		}
	}
	return freq;
}

int main() {
	clock_t t;
	int f;
	t = clock();//记录初始CPU时间
	printf("Calculating...\n");
	f = frequency_of_primes(99999);//计算小于100000的素数的数量
	printf("The number of primes lower than 100,000 is: %d\n", f);
	t = clock() - t;//计算CPU时间差值
	printf("It took me %d clicks (%f seconds).\n", t, ((float)t) / CLOCKS_PER_SEC);
}//possible output:
Calculating...
The number of primes lower than 100,000 is: 9592
It took me 61 clicks (0.061000 seconds).
```





###### struct tm

```cpp
struct tm {
	int tm_sec;//秒 – 取值区间为[0,59]
	int tm_min;//分 - 取值区间为[0,59]
	int tm_hour;//时 - 取值区间为[0,23]
	int tm_mday;//一个月中的日期 - 取值区间为[1,31]
	int tm_mon;//月份（从一月开始，0代表一月） - 取值区间为[0,11]
	int tm_year;//年份，其值等于实际年份减去1900
	int tm_wday;//星期 – 取值区间为[0,6]，其中0代表星期天，1代表星期一，以此类推
	int tm_yday;//从每年的1月1日开始的天数 – 取值区间为[0,365]，其中0代表1月1日，1代表1月2日，以此类推
	int tm_isdst; //夏令时标识符，实行夏令时的时候，tm_isdst为正。不实行夏令时的时候，tm_isdst为0；不了解情况时，tm_isdst()为负
	long int tm_gmtoff;//指定了日期变更线东面时区中UTC东部时区正秒数或UTC西部时区的负秒数
	const char *tm_zone;//当前时区的名字(与环境变量TZ有关)
};
```





###### difftime

-   double difftime (time_t end, time_t beginning);

-   返回前者时间-后者时间相差的秒数

```cpp
#include <cstdio>
#include <ctime>//time_t, struct tm, difftime, time, mktime
int main() {
	time_t now;
	struct tm newyear;
	double seconds;
	time(&now);  //get current time; same as: now = time(NULL)
	newyear = *localtime(&now);
	newyear.tm_hour = 0; newyear.tm_min = 0; newyear.tm_sec = 0;
	newyear.tm_mon = 0;  newyear.tm_mday = 1;
	seconds = difftime(now, mktime(&newyear));
	printf("%.f seconds since new year.\n", seconds);
}//possible output:24231037 seconds since new year.
```

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















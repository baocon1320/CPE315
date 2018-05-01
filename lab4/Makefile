CXX = g++
CFLAGS =-pg  -O2 -Wall -g 
SRCS = matadd.s matadd-driver.o
BIN = matadd

all:
	$(CXX) $(CFLAGS) -o $(BIN) $(SRCS)

clean:
	rm -f $(BIN)

CC = g++
CXXFLAGS = -std=c++11 -g -Wall

INCLUDE_FOLDER = ./include/
OBJ_FOLDER = ./obj/
SRC_FOLDER = ./src/

MAIN = main
TARGET = tp01
SRC = $(wildcard $(SRC_FOLDER)*.cpp)
OBJ = $(patsubst $(SRC_FOLDER)%.cpp, $(OBJ_FOLDER)%.o, $(SRC))

$(OBJ_FOLDER)%.o: $(SRC_FOLDER)%.cpp
	$(CC) $(CXXFLAGS) -c $< -o $@ -I$(INCLUDE_FOLDER)

all: $(OBJ)
	$(CC) $(CXXFLAGS) -o $(TARGET) $(OBJ)

clean:
	@rm -rf $(OBJ_FOLDER)* $(TARGET)

commit:
	git add .
	git commit -m "$$ARGS"
	git push
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -Wpedantic -Isrc

TARGET = pascc

SOURCES = \
    src/main.cpp \
    src/common/error.cpp \
    src/ast/ast.cpp \
    src/lexer/lexer.cpp \
    src/parser/parser.cpp \
    src/semantic/analyzer.cpp \
    src/lower/lower.cpp \
    src/codegen/c_writer.cpp \
    src/codegen/c_codegen.cpp \
    src/driver/compiler.cpp

OBJECTS = $(SOURCES:.cpp=.o)

$(TARGET): $(OBJECTS)
	$(CXX) -o $@ $^

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(TARGET)

.PHONY: clean
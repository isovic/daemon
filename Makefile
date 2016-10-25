GCC = g++

BIN = bin/daemon

CC_FLAGS_RELEASE = -O3 -Wall -c -fmessage-length=0 -pthread -std=c++11 -lpthread
CC_FLAGS_DEBUG = -O0 -g -Wall -c -fmessage-length=0 -pthread -std=c++11 -lpthread
CC_LIBS = 
INCLUDE = 

LD_FLAGS = -lpthread -pthread -Wl,--no-as-needed
LIB_DIRS = 
LD_LIBS = 

SOURCE = src
OBJ_DEBUG = obj_debug
OBJ_RELEASE = obj_release
CC_FILES :=  $(wildcard $(SOURCE)/*.cc)
H_FILES := $(wildcard $(SOURCE)/*.h) $(wildcard $(SOURCE)/*.hpp)

OBJ_FILES_DEBUG := $(addprefix $(OBJ_DEBUG)/,$(CC_FILES:.cc=.o))
OBJ_FILES_RELEASE := $(addprefix $(OBJ_RELEASE)/,$(CC_FILES:.cc=.o))

all: debug

debug: $(OBJ_FILES_DEBUG)
	@echo [LD DEBUG] $<
	@mkdir -p $(dir $(BIN))
	@$(GCC) $(LD_FLAGS) $(LIB_DIRS) -o $(BIN) $(OBJ_FILES_DEBUG) $(LD_LIBS)

$(OBJ_DEBUG)/%.o: %.cc $(H_FILES)
	@echo [CP DEBUG] $<
	@mkdir -p $(dir $@)
	@$(GCC) $(CC_LIBS) $(INCLUDE) $(CC_FLAGS_DEBUG) -o $@ $<

release: $(OBJ_FILES_RELEASE)
	@echo [LD RELEASE] $<
	@mkdir -p $(dir $(BIN))
	@$(GCC) $(LD_FLAGS) $(LIB_DIRS) -o $(BIN) $(OBJ_FILES_RELEASE) $(LD_LIBS)

$(OBJ_RELEASE)/%.o: %.cc $(H_FILES)
	@echo [CP RELEASE] $<
	@mkdir -p $(dir $@)
	@$(GCC) $(CC_LIBS) $(INCLUDE) $(CC_FLAGS_RELEASE) -o $@ $<

clean:
	rm -rf $(OBJ_RELEASE) $(OBJ_DEBUG) $(BIN)

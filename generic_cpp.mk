OBJDIR := .obj
DEPDIR := .dep

ifndef CC
CC := clang
endif

ifndef CXX
CXX := clang++
endif

LD = $(CXX)
CFLAGS += -c -MMD -MF $(DEPDIR)/$*.c.d -o
CXXFLAGS += -c -MMD -MF $(DEPDIR)/$*.cpp.d -o
LDFLAGS += -o

RM := rm -rf
MKDIR := mkdir -p

TGT := # target
CSRC := # c source
CXXSRC := # c++ source
OBJ := $(addprefix $(OBJDIR)/, $(CSRC:.c=.c.o)) $(addprefix $(OBJDIR)/, $(CXXSRC:.cpp=.cpp.o))

.PHONY: all clean distclean snapshot

all: $(TGT)

clean: 
	$(RM) $(TGT)
	$(RM) $(OBJDIR)

distclean: clean
	$(RM) $(DEPDIR)

# executable target

$(TGT): $(OBJ)
	$(LD) $(LDFLAGS) $@ $^

# source compilation

$(OBJDIR)/%.c.o: %.c $(OBJDIR) $(DEPDIR)
	$(CC) $(CFLAGS) $@ $<

$(OBJDIR)/%.cpp.o: %.cpp $(OBJDIR) $(DEPDIR)
	$(CXX) $(CXXFLAGS) $@ $<

# directories

$(OBJDIR):
	$(MKDIR) $@

$(DEPDIR):
	$(MKDIR) $@

-include $(wildcard $(DEPDIR)/*.d)

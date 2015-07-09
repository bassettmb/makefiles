OBJDIR := .obj
DEPDIR := .dep

ifndef CC
CC := clang
endif

LD = $(CC)
CFLAGS += -c -MMD -MF $(DEPDIR)/$*.d -o
LDFLAGS += -o

RM := rm -rf
MKDIR := mkdir -p

TGT := # target
SRC := # source
OBJ := $(addprefix $(OBJDIR)/, $(SRC:.c=.o))

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

$(OBJDIR)/%.o: %.c $(OBJDIR) $(DEPDIR)
	$(CC) $(CFLAGS) $@ $<

# directories

$(OBJDIR):
	$(MKDIR) $@

$(DEPDIR):
	$(MKDIR) $@

-include $(wildcard $(DEPDIR)/*.d)

#ifndef _TC_CONTEXT_FCONTEXT_AARCH64_H
#define _TC_CONTEXT_FCONTEXT_AARCH64_H

#include<stdint.h>

namespace tars
{

extern "C"
{

struct stack_t
{
	void * sp;
	std::size_t size;

	stack_t():sp(0),size(0)
	{
	}
};



struct fcontext_t
{
    unsigned long long int fc_greg[12];
    unsigned long long int fc_lr;
    unsigned long long int fc_sp;
	stack_t fc_stack;
	unsigned long long int fc_pc;

	fcontext_t():fc_greg(),fc_lr(),fc_stack()
	{
	}
};

}

}

#endif 

#ifndef _MANABU_DESKTOP_SESSION_H_
#define _MANABU_DESKTOP_SESSION_H_

#include <manabu.h>

namespace Manabu
{
	namespace Desktop
	{
		//! Manages the Manabu client session to a GAKU server
		class Session
		{
			public:
				static Manabu* manabu;
		};
	}
}

#endif /* _MANABU_DESKTOP_SESSION_H_ */

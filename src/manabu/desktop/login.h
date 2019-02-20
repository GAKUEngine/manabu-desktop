
#ifndef _MANABU_DESKTOP_LOGIN_H_
#define _MANABU_DESKTOP_LOGIN_H_

#include <gtkmm.h>

namespace Manabu
{
	namespace Desktop
	{
		//! Displays a login screen
		class Login
		{
			private:
			void buildLoginScreen();

			public:
			Gtk::Window *window;
			Login();
			~Login();
		};
	}
}


#endif /* _MANABU_DESKTOP_LOGIN_H_ */

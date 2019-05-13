#ifndef _MANABU_DESKTOP_DASH_H_
#define _MANABU_DESKTOP_DASH_H_

#include <gtkmm.h>

namespace Manabu
{
	namespace Desktop
	{
		//! Displays the main Dashboard screen
		class Dash : public Gtk::Window
		{
			private:
				void buildDashScreen();

			public:
				//Gtk::Window *window;
				Dash(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refBuilder);
				~Dash();
				static Dash* getInstance();
			protected:
				Gtk::Viewport *studentRosterViewport, *studentFormViewport;
		};
	}
}

#endif /* _MANABU_DESKTOP_DASH_H_ */

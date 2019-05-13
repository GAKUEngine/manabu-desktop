#include "dash.h"
#include "session.h"

#include <iostream>
using namespace std;

Manabu::Desktop::Dash::Dash(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refBuilder)
				: Gtk::Window(cobject)
{
}

Manabu::Desktop::Dash::~Dash()
{
}

Manabu::Desktop::Dash* Manabu::Desktop::Dash::getInstance()
{
	clog << "Creating Dashboard screen..." << endl;
	Dash *screen;
	Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create_from_resource("/layouts/dash.glade");

	builder->get_widget_derived("dash.Window", screen);
	
	// stundet tab content
	builder->get_widget("tab_student.Viewport", screen->studentViewport);

	Glib::RefPtr<Gtk::Builder> rosterBuilder = Gtk::Builder::create_from_resource("/layouts/student_roster.glade");
	Gtk::Box *rosterBox;
	rosterBuilder->get_widget("student_roster.Box", rosterBox);

	screen->studentViewport->add(*rosterBox);
	
	// TODO: 生徒一覧を取ってくる。
	// 生徒一覧を取ってきたらrosterBuilderにあるstudent_row.ListBoxRowをテンプレートにしてrowを作成する。
	// 作成したらstudent_roster_list.Boxの中に入れる

	return screen;
}

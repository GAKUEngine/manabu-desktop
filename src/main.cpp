#include <gtk/gtk.h>

int main(int argc, char *argv[])
{
	GtkBuilder *builder;
	GtkWidget *window;

	gtk_init(&argc, &argv);

	// Use builder to build from GLADE layout
	builder = gtk_builder_new();
	gtk_builder_add_from_file(builder, "../layouts/main.glade", NULL);

	// Init main window
	window = GTK_WIDGET(gtk_builder_get_object(builder, "main.Window"));
	gtk_builder_connect_signals(builder, NULL);

	// Cleanup builder
	g_object_unref(builder);

	gtk_widget_show(window);
	gtk_main();

	return 0;
}

void on_main_window_destroy()
{
	gtk_main_quit();
}

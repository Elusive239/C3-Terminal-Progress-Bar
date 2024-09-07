module progressbarc3;
import std::io;
import tc;
import pgbar;

fn int main(String[] args)
{
	tc::enter_alt_screen();
	int term_width;
	int term_height;
	tc::get_cols_rows(&term_width, &term_height);
	pgbar::ProgressBar bar;
	bar.init(term_width/2, "Progress: ");
	for(int i =0; 10 >= i; i++){
		bar.update((float)i/10f);
		// io::printfn("%s", bar);
		tc::printfn("%s", bar.show_progress());
		// io::printfn("%s", bar);
	}
	tc::getch();
	tc::exit_alt_screen();

	return 0;
}
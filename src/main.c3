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
	bar.init(term_width, "Progress: ");
	float maximum = 23;
	for(int i =0; maximum >= i; i++){
		tc::clear_screen();
		bar.update((float)i/maximum);
		tc::printfn_at(0, term_height-1, "%s", bar.show_progress());
		tc::getch();
	}
	tc::printfn("%s", "Finished!");
	tc::getch();
	tc::exit_alt_screen();

	return 0;
}
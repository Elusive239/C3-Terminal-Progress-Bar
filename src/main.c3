module progressbarc3;
import std::io;
import tc;
import pgbar;

fn int main(String[] args)
{
	int term_width; int term_height;
	int cx; int cy;
	tc::get_cols_rows(&term_width, &term_height);
	tc::get_cursor(&cx, &cy);
	pgbar::ProgressBar bar;
	bar.init(term_width, "Working:");
	bar.set_color(tc::GRN.str_view());
	int demo_max = 325;
	for(int i =0; demo_max >= i; i++){
		bar.update((float)i/demo_max);
		tc::printf_at(cx, cy, "%s", (ZString) bar.show_progress());
	}
	tc::print("\n");
	return 0;
}
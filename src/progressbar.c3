module pgbar;
import std::core;
import std::io;
import std::math;

//works on windows, may need different on POSIX/LINUX
const String NORMAL = "\x1B[0m";

struct ProgressBar (Printable){
	int term_width;
	float progress;
	char finished;
	char in_progress;
	String info_text;
	String text_color;
}

fn void ProgressBar.init(&self, int term_width, String info_text = "", char finished = '#', char in_progress = '-') @inline{
	self.term_width = term_width;
	self.finished = finished;
	self.in_progress = in_progress;
	self.info_text = info_text;
	self.text_color = NORMAL;
	self.progress = 0;
}

//should be a number between 0 & 1, inclusive
fn void ProgressBar.update(&self, float current){
	self.progress = current;
}

fn void ProgressBar.set_color(&self, String color){
	self.text_color = color;
}

fn String ProgressBar.show_progress(&self){
	 //termwidth - 2(the '[' and ']' characters) - ?(info_text.len) - 8 (progress_text.len)
	@pool(){
		String progress_text = core::string::new_format(" %.1f%% ", self.progress*100f);
		int width = self.term_width - (2 + self.info_text.len + 8);
		int finished_width = (int) math::floor(width * self.progress);
		DString dstr = std::core::dstring::temp_new();
		dstr.appendf("%s",NORMAL);
		dstr.append(self.info_text);
		for(int i = 0; i < 8- progress_text.len; i++){
			dstr.append_char(' ');
		}
		dstr.append(progress_text);
		dstr.append_char('[');
		dstr.appendf("%s", self.text_color);
		for(int i = 0; i < finished_width; i++){	
			dstr.append_char(self.finished);
		}
		dstr.appendf("%s",NORMAL);
		for(int i = 0; i < width - finished_width; i++){	
			dstr.append_char(self.in_progress);
		}
		dstr.appendf("%s",NORMAL);
		dstr.append_char(']');
		return dstr.copy_str();
	};
}

//NOTE: Printable is located in formatter.c3!
fn String ProgressBar.to_string(ProgressBar* bar, Allocator allocator) @dynamic
{
	return string::format("progress: %s, finishedChar: %s, inprogressChar: %s, terminalWidth: %s",
	bar.progress, bar.finished, bar.in_progress, bar.term_width ,allocator: allocator);  //bar.show_progress();
}


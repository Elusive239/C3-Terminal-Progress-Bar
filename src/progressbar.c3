module pgbar;
import std::core;
import std::io;
import std::math;

struct ProgressBar (Printable){
	int term_width;
	float progress;
	char finished;
	char in_progress;
	String info_text;
}

fn void ProgressBar.init(&self, int term_width, String info_text = "", char finished = '#', char in_progress = '-') @inline{
	self.term_width = term_width;
	self.finished = finished;
	self.in_progress = in_progress;
	self.info_text = info_text;
	self.progress = 0;
}

//should be a number between 0 & 1, inclusive
fn void ProgressBar.update(&self, float current){
	self.progress = current;
}

fn String ProgressBar.show_progress(&self){
	int width = self.term_width - (2 + self.info_text.len); //termwidth - 2(the '[' and ']' characters) - length of info text
	int finished_width = (int) math::floor(width * self.progress);
	// io::printfn("Width: %s Finished Width: %s", width, finished_width);
	@pool(){
		DString dstr = std::core::dstring::temp_new();
		dstr.append(self.info_text);
		dstr.append_char('[');
		for(int i = 0; i < finished_width; i++){
			dstr.append_char(self.finished);
		}
		for(int i = 0; i < width - finished_width; i++){
			dstr.append_char(self.in_progress);
		}
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


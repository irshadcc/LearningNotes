

struct ImportantExcerpt<'a> {
    part: &'a str,
}

impl<'a> ImportantExcerpt<'a> {

    pub fn display(self) -> String {
        return self.part.to_string()
    }

}

fn main() {
    let novel = String::from("Call me Ishmael. Some years ago...");
    let i : ImportantExcerpt ;

    {
        let first_sentence = novel.split('.').next().unwrap();
        i = ImportantExcerpt {
            part: first_sentence,
        };
    }

    print!("{}", i.display());
}
    


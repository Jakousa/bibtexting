import com.bibtextingcompany.bibtexting.*
import com.bibtextingcompany.domain.Article

description 'User can search (by title) and view a specific reference in the database'

scenario "user can view a specific article with a matching title", {
    given 'command view selected', {
        refDB = new ReferenceDatabase();
        refDB.add(new Article("a01", "John Doe", "The Future of BibteX", 2015, "The Computer Science Journal", 10, 2, "30-34"))
        refDB.add(new Article("a02", "Jane Doe", "BibteX and You", 2011, "Useless Proceedings in Computer Science", 5, 1, "12-17"))      
        io = new StubIO("view", "    the future of bibtex   ", "exit")
        ui = new ConsoleUI(io, refDB)
    }

    when 'title to be searched is entered', {
        ui.run()
    }

    then 'a matching article is returned', {
        io.getPrints().shouldHave("The Future of BibteX")
        io.getPrints().shouldNotHave("BibteX and You")
    }
}

scenario "user can view multiple articles with the same title", {
    given 'command view selected', {
        refDB = new ReferenceDatabase();
        refDB.add(new Article("a01", "John Doe", "The Future of BibteX", 2015, "The Computer Science Journal", 10, 2, "30-34"))
        refDB.add(new Article("a02", "Jane Doe", "The Future of BibteX", 2011, "Useless Proceedings in Computer Science", 5, 1, "12-17")) 
        io = new StubIO("view", "the future of bibtex", "exit")
        ui = new ConsoleUI(io, refDB)
    }

    when 'title to be searched is entered', {
        ui.run()
    }

    then 'the matching articles are returned', {
        io.getPrints().shouldHave("John Doe")
        io.getPrints().shouldHave("Jane Doe")
    }
}

scenario "user can view an article which has unicode characters", {
    given 'command view selected', {
        refDB = new ReferenceDatabase();
        refDB.add(new Article("a01", "John Doe", "The Future of BibteX", 2015, "The Computer Science Journal", 10, 2, "30-34"))
        title = StringValidator.Validate("Sinä ja BibteX")
        refDB.add(new Article("a02", "Janne Johnson", title, 2011, "Useless Proceedings in Computer Science", 5, 1, "12-17")) 
        io = new StubIO("view", "   sinä ja bibtex   ", "exit")
        ui = new ConsoleUI(io, refDB)
    }

    when 'title to be searched is entered', {
        ui.run()
    }

    then 'a matching article is returned', {
        io.getPrints().shouldHave(title)
        io.getPrints().shouldNotHave("The Future of BibteX")
    }
}

scenario "if no article is found with a matching title then nothing is returned", {
    given 'command view selected', {
        refDB = new ReferenceDatabase();
        refDB.add(new Article("a01", "John Doe", "The Future of BibteX", 2015, "The Computer Science Journal", 10, 2, "30-34"))
        io = new StubIO("view", "   bibtex and you   ", "exit")
        ui = new ConsoleUI(io, refDB)
    }

    when 'title to be searched is entered', {
        ui.run()
    }

    then 'no articles are returned', {
        io.getPrints().shouldHave("No references found with the specified search terms!")
    }
}
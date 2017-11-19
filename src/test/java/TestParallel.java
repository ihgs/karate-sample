import com.intuit.karate.cucumber.CucumberRunner;
import com.intuit.karate.cucumber.KarateStats;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import cucumber.api.CucumberOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import static org.junit.Assert.assertTrue;
import org.junit.Test;

@CucumberOptions(tags = {"~@ignore"})
public class TestParallel {

    @Test
    public void testParallel() {
        String karateOutputPath = "build/karate/surefire-reports";
        KarateStats stats = CucumberRunner.parallel(getClass(), 5, karateOutputPath);
        generateReport(karateOutputPath);
        assertTrue("there are scenario failures", stats.getFailCount() == 0);
    }

    private static void generateReport(String karateOutputPath) {
         Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
         List<String> jsonPaths = new ArrayList(jsonFiles.size());
         for (File file : jsonFiles) {
             jsonPaths.add(file.getAbsolutePath());
         }
         Configuration config = new Configuration(new File("build/karate"), "qiita");
         ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
         reportBuilder.generateReports();
     }
}

package com.frattoninteractive.pulse.architecture;

import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.core.importer.ImportOption;
import com.tngtech.archunit.lang.ArchRule;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.classes;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.fields;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;

class ArchitectureRulesTest {

    private static final String BASE_PACKAGE = "com.frattoninteractive.pulse";

    private final JavaClasses productionClasses = new ClassFileImporter()
            .withImportOption(ImportOption.Predefined.DO_NOT_INCLUDE_TESTS)
            .importPackages(BASE_PACKAGE);

    @Test
    void repositoriesMustNotDependOnControllers() {
        ArchRule rule = noClasses()
                .that().haveSimpleNameEndingWith("Repository")
                .should().dependOnClassesThat().haveSimpleNameEndingWith("Controller");

        rule.check(productionClasses);
    }

    @Test
    void controllersMustNotAccessRepositoriesDirectly() {
        ArchRule rule = noClasses()
                .that().haveSimpleNameEndingWith("Controller")
                .should().dependOnClassesThat().haveSimpleNameEndingWith("Repository");

        rule.check(productionClasses);
    }

    @Test
    void fieldInjectionIsForbiddenInProductionCode() {
        ArchRule rule = fields()
                .should().notBeAnnotatedWith(Autowired.class);

        rule.check(productionClasses);
    }

    @Test
    void controllersMustResideInFeaturePackages() {
        ArchRule rule = classes()
                .that().haveSimpleNameEndingWith("Controller")
                .should().resideOutsideOfPackage(BASE_PACKAGE + ".config..");

        rule.check(productionClasses);
    }
}

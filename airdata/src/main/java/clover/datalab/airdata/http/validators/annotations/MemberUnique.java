package clover.datalab.airdata.http.validators.annotations;

import clover.datalab.airdata.enums.MemberUniqueType;
import clover.datalab.airdata.http.validators.ServerValidator;
import jakarta.validation.Constraint;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import jakarta.validation.Payload;
import lombok.RequiredArgsConstructor;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = MemberUnique.Validator.class)
public @interface MemberUnique {

    String message();

    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};

    MemberUniqueType type();

    @RequiredArgsConstructor
    class Validator implements ConstraintValidator<MemberUnique, String> {

        private MemberUniqueType memberUniqueType;

        private final ServerValidator validator;

        @Override
        public void initialize(MemberUnique constraintAnnotation) {
            memberUniqueType = constraintAnnotation.type();
        }

        @Override
        public boolean isValid(String value, ConstraintValidatorContext context) {
            return validator.isMemberUnique(memberUniqueType, value);
        }

    }

}

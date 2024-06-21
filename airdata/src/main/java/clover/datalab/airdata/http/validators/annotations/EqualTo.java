package clover.datalab.airdata.http.validators.annotations;

import jakarta.validation.Constraint;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import jakarta.validation.Payload;
import org.springframework.beans.BeanWrapperImpl;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = EqualTo.Validator.class)
public @interface EqualTo {

    String message();

    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};

    String first();
    String second();

    class Validator implements ConstraintValidator<EqualTo, Object> {

        private String firstFieldName;
        private String secondFieldName;
        private String message;

        @Override
        public void initialize(EqualTo constraintAnnotation) {
            firstFieldName = constraintAnnotation.first();
            secondFieldName = constraintAnnotation.second();
            message = constraintAnnotation.message();
        }

        @Override
        public boolean isValid(final Object value, final ConstraintValidatorContext context) {
            boolean valid = true;

            try {
                final Object firstObject = new BeanWrapperImpl(value).getPropertyValue(firstFieldName);
                final Object secondObject = new BeanWrapperImpl(value).getPropertyValue(secondFieldName);
                valid = firstObject == null && secondObject == null || firstObject != null && firstObject.equals(secondObject);
            } catch (final Exception ignore) { }

            if (!valid) {
                context.buildConstraintViolationWithTemplate(message)
                       .addPropertyNode(firstFieldName)
                       .addConstraintViolation()
                       .disableDefaultConstraintViolation();
            }

            return valid;
        }

    }

}

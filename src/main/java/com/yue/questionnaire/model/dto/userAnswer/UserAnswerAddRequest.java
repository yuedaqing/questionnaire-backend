package com.yue.questionnaire.model.dto.userAnswer;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 创建用户答题记录请求
 *
 * @author <a href="https://github.com/yuedaqing">岳岳</a>
 * 
 */
@Data
public class UserAnswerAddRequest implements Serializable {
    /**
     * 应用 id
     */
    private Long appId;

    /**
     * 用户答案（JSON 数组）
     */
    private List<String> choices;
    private static final long serialVersionUID = 1L;
}
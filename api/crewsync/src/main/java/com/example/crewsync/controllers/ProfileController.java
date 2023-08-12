package com.example.crewsync.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.crewsync.common.utils.constants.RouteConstants;
import com.example.crewsync.controllers.forms.ProfileEditForm;
import com.example.crewsync.domains.models.ImageFile;
import com.example.crewsync.domains.services.ProfileEditService;
import com.example.crewsync.security.LoginUser;
import com.example.crewsync.security.LoginUserDetails;

import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProfileController {

    private final ProfileEditService profileEditService;

    @Autowired
    public ProfileController(ProfileEditService profileEditService) {
        this.profileEditService = profileEditService;
    }

    /**
     * プロフィール編集画面初期表示処理です
     *
     * @param user  ユーザー情報
     * @param model モデル
     * @return 遷移先
     */
    @GetMapping("/profile")
    public String initProfile(@AuthenticationPrincipal LoginUserDetails userDetails, Model model) {
        LoginUser user = userDetails.getLoginUser();
        ProfileEditForm form = profileEditService.initPersonalInfo(user);
        model.addAttribute("profileEditForm", form);
        model.addAttribute("loginUser", user);
        return RouteConstants.PROFILE;
    }

    /**
     * プロフィール編集処理を実行します
     *
     * @param profileEditForm プロフィール編集フォーム
     * @param result          バリデーションエラー結果
     * @param model           モデル
     * @param user            ユーザー情報
     * @return 遷移先
     */
    @PostMapping("/profile/edit")
    public String onEditProfile(@Valid @ModelAttribute ProfileEditForm profileEditForm, BindingResult result,
            Model model, @AuthenticationPrincipal LoginUserDetails userDetails) {
        LoginUser user = userDetails.getLoginUser();
        model.addAttribute("loginUser", user);
        if (result.hasErrors()) {
            return RouteConstants.PROFILE;
        }
        try {
            profileEditService.editProfile(user, profileEditForm);
            model.addAttribute("success", "処理が正常に完了しました");
        } catch (Exception e) {
            log.error("プロフィールの更新に失敗しました: {}", e.getMessage());
            // サムネイルの再表示のため再度プロフィール画像をセットする
            ImageFile imageFile = profileEditService.getProfileImg(user.getId());
            user.setImageFile(imageFile);
            model.addAttribute("loginUser", user);
            model.addAttribute("failure", "処理に失敗しました。再度実行してください");
        }
        return RouteConstants.PROFILE;
    }
}

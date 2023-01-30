Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEE26814FA
	for <lists+linux-raid@lfdr.de>; Mon, 30 Jan 2023 16:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjA3P1z (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Jan 2023 10:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjA3P1y (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Jan 2023 10:27:54 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2096449A
        for <linux-raid@vger.kernel.org>; Mon, 30 Jan 2023 07:27:51 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id h19so11072971vsv.13
        for <linux-raid@vger.kernel.org>; Mon, 30 Jan 2023 07:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzC+G7JXGUMEMTg+296rqY8TNpbshezIFmO/f2WmN2c=;
        b=PLkl64n3N19/gGvGrzaUEowzic6UEZ8ferjBThtlDecH4ToqyGU8TvrPNlvzW2wh+W
         LhMmKfvQEveY4aVDamUVFhlC5arXZ0i+k+qJSAZOqS0qdvoe2pzALE3JNSZ2HITgnXup
         mQ3NNCb9MWgUU9tLD/zVuSOZxsxhsoJThXguY3eXCHzTkqqorhW1bLm88YxN96/ZDo5S
         kOr/0uRM2woqE5DN+OLu0qth+iLCkhVvsKvjezmdjNS7jkhqL/VGMBjvfBCxc3mW5bo+
         pm1WlD857VY1WSlwrp8o65sVB9Tu40NBnIQC1eXpe4OJ56+y2wwxZPDcpdAWS45d4pkA
         CW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzC+G7JXGUMEMTg+296rqY8TNpbshezIFmO/f2WmN2c=;
        b=D9i5wjN9No9CaQN1Lj2ROOIV6LtWsw74WE9OlQOVc/GQJx510wDfZqqfbpYnCZjfLE
         5yHKxL1ylD8+DSo/fCCol8I2C5e3cRklG/ZKxFveEXTMcgrfJjNfC4Z7NVnBICabNVlG
         rKRRG4AA0iaLLt4KvurCF9K+bSdOpkaUEZrD9w5JHgmxzDmizc0sFnTbwSyb0pbFpBlF
         gYJwP1EfXsBZKFF0I+nSpLW95gOZDpVETAuYFg451SpcccNgeu84+TpKR/tJWHg98xaG
         CBrjyXZdYGE9Vocqwv0/Bn9kNjZRse0B456CFPY15rE1I8uZwcmpbPlHNdcZMY02wEA3
         HNzg==
X-Gm-Message-State: AFqh2kqNM2hSYPpyhe1ZoC1N9DxgX4fWGoyE6/yHVrjEyoWXCSmgblc5
        sZrrRHZn13Ddrmtn/qmpTdnk3hyMvsaNacm87Pk=
X-Google-Smtp-Source: AMrXdXvgu7cQRaoj5oIiYgH+IJTciiOTZmI9qfIkGJA+gRl3DC+mQyt0i/I0Pmfjmf9an+yL5RqnCNvem/N8+E2eo9Y=
X-Received: by 2002:a05:6102:5492:b0:3d1:f60a:f8e9 with SMTP id
 bk18-20020a056102549200b003d1f60af8e9mr6505678vsb.12.1675092470739; Mon, 30
 Jan 2023 07:27:50 -0800 (PST)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: tombaba466@gmail.com
Received: by 2002:a59:d06e:0:b0:38a:bf46:ed0b with HTTP; Mon, 30 Jan 2023
 07:27:50 -0800 (PST)
From:   "Mr. Sal Kavar" <salkavar2@gmail.com>
Date:   Mon, 30 Jan 2023 07:27:50 -0800
X-Google-Sender-Auth: v1oJsZi1lWRU3wpbY5wcaMceR3k
Message-ID: <CAOwfnHajhhdOG+ds-xhj=1WrAwsLBay+nBNzNZue2P=2QQdZxw@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

ScKgYXNzdW1lwqB5b3XCoGFuZMKgeW91csKgZmFtaWx5wqBhcmXCoGluwqBnb29kwqBoZWFsdGgu
DQoNClN1bcKgb2bCoCQxNS41bSzCoChGaWZ0ZWVuwqBNaWxsaW9uwqBGaXZlwqBIdW5kcmVkwqBU
aG91c2FuZMKgRG9sbGFyc8KgT25seSkNCndoZW7CoHRoZcKgYWNjb3VudMKgaG9sZGVywqBzdWRk
ZW5secKgcGFzc2VkwqBvbizCoGhlwqBsZWZ0wqBub8KgYmVuZWZpY2lhcnnCoHdobw0Kd291bGTC
oGJlwqBlbnRpdGxlZMKgdG/CoHRoZcKgcmVjZWlwdMKgb2bCoHRoaXPCoGZ1bmQuwqBGb3LCoHRo
aXPCoHJlYXNvbizCoEnCoGhhdmUNCmZvdW5kwqBpdMKgZXhwZWRpZW50wqB0b8KgdHJhbnNmZXLC
oHRoaXPCoGZ1bmTCoHRvwqBhwqB0cnVzdHdvcnRoecKgaW5kaXZpZHVhbA0Kd2l0aMKgY2FwYWNp
dHnCoHRvwqBhY3TCoGFzwqBmb3JlaWduwqBidXNpbmVzc8KgcGFydG5lci4NCg0KWW91wqB3aWxs
wqB0YWtlwqA0NSXCoDEwJcKgd2lsbMKgYmXCoHNoYXJlZMKgdG/CoENoYXJpdHnCoGluwqBib3Ro
wqBjb3VudHJpZXPCoGFuZA0KNDUlwqB3aWxswqBiZcKgZm9ywqBtZS4NCg0KDQpNci5TYWzCoEth
dmFyLg0K
